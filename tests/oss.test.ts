import fs from 'node:fs'
import { load } from 'js-yaml'
import { update_oss } from '../scripts/update-oss'
import { expect, it, vi } from 'vite-plus/test'

const repo = `https://github.com/janosh/blog`
const repo_url = `https://api.github.com/repos/janosh/blog`
const repository = { stargazers_count: 100 }
const me = { login: `janosh`, contributions: 42 }
const full_page = Array.from({ length: 100 }, (_, idx) => ({ login: `user-${idx}` }))
const network_error = new Error(`fetch failed`)
const timeout_error = new Error(`The operation was aborted due to timeout`)

it.each([
  [`first page`, [repository, [me]], 42],
  [`second page`, [repository, full_page, [me]], 42],
  [`absent`, [repository, full_page, []], 0],
  [`empty`, [repository, new Response(null, { status: 204 })], 0],
  [`organization`, [], 9],
  [`repo status`, [new Response(null, { status: 503 })], /GitHub API 503/],
  [`malformed repository`, [{}], /Invalid repository response/],
  [
    `contributors status`,
    [repository, new Response(null, { status: 403 })],
    /GitHub API 403/,
  ],
  [`malformed contributors`, [repository, {}], /Invalid contributors response/],
  [
    `malformed count`,
    [repository, [{ ...me, contributions: `wrong` }]],
    /Invalid contribution count/,
  ],
  [`network failure`, [network_error], network_error],
  [`timeout`, [timeout_error], timeout_error],
  [`invalid JSON`, [new Response(`not JSON`)], /GitHub request failed/],
  [`concurrent edit`, [repository, [me]], /oss.yml changed/],
] as const)(`refreshes the catalog: %s`, async (mode, responses, expected) => {
  const project = { repo, stars: 1, commits: 9 }
  if (mode === `organization`)
    project.repo = `https://github.com/materialsproject#contributors`
  const source = JSON.stringify({ projects: [project] })
  vi.spyOn(fs, `readFileSync`)
    .mockReturnValue(mode === `concurrent edit` ? `edited` : source)
    .mockReturnValueOnce(source)
  const write = vi.spyOn(fs, `writeFileSync`).mockImplementation(() => {})
  const timeout = vi.spyOn(AbortSignal, `timeout`)
  const queue: unknown[] = [...responses]
  const fetch_mock = vi.fn<typeof fetch>(async () => {
    const response = queue.shift()
    if (response instanceof Error) throw response
    return response instanceof Response ? response : Response.json(response)
  })
  vi.stubGlobal(`fetch`, fetch_mock)
  const update = update_oss(`test-token`)
  if (typeof expected === `number`) {
    await update
    expect(write).toHaveBeenCalledOnce()
    const written = write.mock.calls[0][1]
    if (typeof written !== `string`) throw new TypeError(`Expected YAML text`)
    expect(load(written)).toEqual({
      projects: [{ ...project, stars: responses.length ? 100 : 1, commits: expected }],
    })
    expect(fetch_mock).toHaveBeenCalledTimes(responses.length)
    if (responses.length) {
      expect(timeout).toHaveBeenCalledWith(10_000)
      expect(fetch_mock.mock.calls[0][1]?.headers).toEqual({
        Authorization: `Bearer test-token`,
      })
      expect(fetch_mock.mock.lastCall?.[0]).toBe(
        `${repo_url}/contributors?per_page=100&page=${responses.length - 1}`,
      )
    }
  } else {
    await expect(update).rejects.toThrow(
      expected instanceof Error ? expected.message : expected,
    )
    if (mode !== `concurrent edit`) await expect(update).rejects.toThrow(repo_url)
    if (expected instanceof Error)
      await expect(update).rejects.toHaveProperty(`cause`, expected)
    if (mode === `invalid JSON`)
      await expect(update).rejects.toHaveProperty(`cause`, expect.any(SyntaxError))
    expect(write).not.toHaveBeenCalled()
  }
})

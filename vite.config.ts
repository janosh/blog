import rollup_yaml from '@rollup/plugin-yaml'
import { sveltekit } from '@sveltejs/kit/vite'
import { dump, load } from 'js-yaml'
import { execSync } from 'node:child_process'
import fs from 'node:fs'
import { defineConfig } from 'vite-plus'

async function fetch_github_data(gh_token: string) {
  const auth = { headers: { Authorization: `token ${gh_token}` } }
  const cv = load(fs.readFileSync(`src/lib/oss.yml`, `utf8`))
  if (
    !cv ||
    typeof cv !== `object` ||
    !(`projects` in cv) ||
    !Array.isArray(cv.projects)
  ) {
    throw new Error(`Invalid oss.yml structure`)
  }

  for (const project of cv.projects) {
    const handle = String(project.repo).replace(`https://github.com/`, ``)

    const repo_resp = await fetch(`https://api.github.com/repos/${handle}`, auth)
    if (!repo_resp.ok) {
      console.error(`GitHub API ${repo_resp.status} for ${handle}, skipping`)
      continue
    }
    const repo = await repo_resp.json()
    project.stars = repo.stargazers_count

    const contribs_resp = await fetch(
      `https://api.github.com/repos/${handle}/contributors`,
      auth,
    )
    if (!contribs_resp.ok) continue
    const contributors = await contribs_resp.json()
    const me = contributors.find(
      (contributor: Record<string, unknown>) => contributor.login === `janosh`,
    )
    if (me) {
      project.commits = me.contributions
    }
  }

  fs.writeFileSync(`src/lib/oss.yml`, dump(cv, { lineWidth: -1 }))
}

try {
  const gh_token = execSync(`gh auth token`, { encoding: `utf8` }).trim()
  void fetch_github_data(gh_token)
} catch {
  console.error(`No GitHub token found, skipping GitHub API calls`)
}

export default defineConfig({
  // Skip all CSS polyfills — only target latest browsers
  css: { lightningcss: { exclude: 0x1fffff } },
  fmt: {
    semi: false,
    singleQuote: true,
    printWidth: 90,
  },
  lint: {
    plugins: [`oxc`, `typescript`, `unicorn`, `import`, `jest`],
    options: {
      typeAware: true,
      typeCheck: true,
    },
    categories: {
      correctness: `error`,
      suspicious: `error`,
      perf: `error`,
      pedantic: `error`,
    },
    ignorePatterns: [`build/`, `.svelte-kit/`],
    rules: {
      'no-unused-vars': `off`,
      '@typescript-eslint/no-unused-vars': [
        `error`,
        { argsIgnorePattern: `^_`, varsIgnorePattern: `^_` },
      ],
      'no-console': [`error`, { allow: [`warn`, `error`] }],
      'no-self-assign': `off`,
      'no-await-in-loop': `off`, // fetch_github_data uses sequential await in loop
      'no-shadow': `off`,
      'prefer-const': `off`,
      '@typescript-eslint/no-unnecessary-condition': `off`,
      '@typescript-eslint/consistent-type-imports': `off`,
      'eslint-plugin-unicorn/consistent-function-scoping': `off`,
      '@typescript-eslint/no-unsafe-argument': `off`,
      '@typescript-eslint/no-unsafe-assignment': `off`,
      '@typescript-eslint/no-unsafe-call': `off`,
      '@typescript-eslint/no-unsafe-member-access': `off`,
      '@typescript-eslint/no-unsafe-return': `off`,
      'no-inline-comments': `off`,
      'no-confusing-void-expression': `off`,
      'no-promise-executor-return': `off`,
      'strict-boolean-expressions': `off`,
      'max-lines-per-function': `off`,
      'max-lines': `off`,
      'max-depth': `off`,
      'max-classes-per-file': `off`,
      'sort-vars': `off`,
      'eslint-plugin-jest/no-conditional-in-test': `off`,
      'eslint-plugin-unicorn/no-array-callback-reference': `off`,
      'eslint-plugin-unicorn/no-useless-undefined': `off`,
      'eslint-plugin-unicorn/no-object-as-default-parameter': `off`,
      'eslint-plugin-import/no-self-import': `off`,
      'eslint-plugin-import/no-unassigned-import': `off`, // CSS imports are side-effect-only
      'eslint-plugin-import/max-dependencies': `off`,
      'eslint-plugin-unicorn/prefer-top-level-await': `off`,
      'no-warning-comments': `off`,
      'only-throw-error': `off`,
    },
  },
  staged: {
    '*.{js,ts,svelte,html,css,md,json,yaml}': `vp check --fix`,
    '*.{ts,svelte}': `sh -c 'npx svelte-kit sync && npx svelte-check-rs --threshold error'`,
    '*': `codespell --ignore-words-list falsy --check-filenames`,
  },
  plugins: [sveltekit(), rollup_yaml()],

  server: {
    port: 3000,
    fs: {
      allow: [`..`],
    },
  },

  preview: {
    port: 3000,
  },

  ssr: {
    noExternal: [`three`],
  },
})

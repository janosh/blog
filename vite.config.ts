import rollup_yaml from '@rollup/plugin-yaml'
import { sveltekit } from '@sveltejs/kit/vite'
import { dump, load } from 'js-yaml'
import { execSync } from 'node:child_process'
import fs from 'node:fs'
import { defineConfig } from 'vite-plus'

interface OssYaml {
  projects: Array<Record<string, unknown>>
}

function is_oss_yaml(data: unknown): data is OssYaml {
  return (
    !!data &&
    typeof data === `object` &&
    `projects` in data &&
    Array.isArray(data.projects)
  )
}

async function fetch_github_data(gh_token: string) {
  const auth = { headers: { Authorization: `token ${gh_token}` } }
  const cv = load(fs.readFileSync(`src/lib/oss.yml`, `utf8`))
  if (!is_oss_yaml(cv)) {
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
    const me = contributors.find?.(
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
    plugins: [`oxc`, `typescript`, `unicorn`, `import`],
    options: {
      typeAware: true,
      typeCheck: true,
    },
    categories: {
      correctness: `error`,
      suspicious: `error`,
      perf: `error`,
    },
    ignorePatterns: [`build/`, `.svelte-kit/`],
    rules: {
      '@typescript-eslint/no-explicit-any': `error`,
      '@typescript-eslint/no-non-null-asserted-optional-chain': `error`,
      '@typescript-eslint/no-non-null-assertion': `error`,
      'no-unused-vars': `error`,
      'no-eval': `error`,
      eqeqeq: `error`,
      'no-var': `error`,
      'no-throw-literal': `error`,
      'no-useless-rename': `error`,
      'no-self-compare': `error`,
      'no-template-curly-in-string': `error`,
      'no-constructor-return': `error`,
      'no-console': [`error`, { allow: [`warn`, `error`] }],
      'default-param-last': `error`,
      'guard-for-in': `error`,
      'require-await': `error`,
      'eslint-plugin-unicorn/no-useless-spread': `error`,
      'eslint-plugin-unicorn/prefer-string-replace-all': `error`,
      'eslint-plugin-unicorn/catch-error-name': `error`,
      'eslint-plugin-unicorn/prefer-set-has': `error`,
      'eslint-plugin-unicorn/prefer-array-find': `error`,
      'eslint-plugin-unicorn/prefer-dom-node-append': `error`,
      'eslint-plugin-import/no-duplicates': `error`,
      'no-inner-declarations': `error`,
      'eslint-plugin-unicorn/prefer-global-this': `error`,
      'eslint-plugin-unicorn/no-lonely-if': `error`,
      'eslint-plugin-unicorn/no-negated-condition': `error`,
      'eslint-plugin-unicorn/no-typeof-undefined': `error`,
      'eslint-plugin-unicorn/prefer-optional-catch-binding': `error`,
      'eslint-plugin-unicorn/no-length-as-slice-end': `error`,
      'eslint-plugin-unicorn/prefer-node-protocol': `error`,
      'eslint-plugin-unicorn/prefer-regexp-test': `error`,
      'eslint-plugin-unicorn/throw-new-error': `error`,
      'eslint-plugin-unicorn/prefer-includes': `error`,
      'eslint-plugin-unicorn/prefer-type-error': `error`,
      'eslint-plugin-unicorn/prefer-date-now': `error`,
      'eslint-plugin-unicorn/require-number-to-fixed-digits-argument': `error`,
      'eslint-plugin-unicorn/no-useless-promise-resolve-reject': `error`,
      // Rules too noisy for this codebase
      'no-await-in-loop': `off`, // fetch_github_data uses sequential await in loop
      'no-shadow': `off`,
      'eslint-plugin-unicorn/consistent-function-scoping': `off`,
      'eslint-plugin-import/no-unassigned-import': `off`, // CSS imports are side-effect-only
    },
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

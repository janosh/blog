/*
#!/bin/sh
#
# Pre-commit hook called by "git commit" with no arguments.
# Checks staged .js(x) files for eslint errors.
# Exits with non-zero status after issuing an appropriate message if
# it wants to stop the commit.
# Place in {projectRoot}/.git/hooks/pre-commit

git diff --diff-filter=d --cached --name-only | grep "\.js.\?$" | xargs ./node_modules/.bin/eslint
*/

module.exports = {
  env: {
    browser: true,
    es6: true,
    node: true,
  },
  extends: ["eslint:recommended", "plugin:react/recommended"],
  parser: "babel-eslint",
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 2018,
    sourceType: "module",
  },
  plugins: ["react"],
  rules: {
    indent: ["error", 2, { SwitchCase: 1 }],
    quotes: ["error", "backtick", { avoidEscape: true }],
    semi: ["error", "never"],
    "linebreak-style": ["error", "unix"],
    "react/prop-types": "off",
    "react/display-name": "off",
  },
  settings: {
    react: {
      version: "detect",
    },
  },
}

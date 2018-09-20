// Run `rm .cache/api-runner-ssr.js` before calling
// `gatsby develop` for changes in this file to take effect.

const macros = {
  // Infinitesimal differential (used in derivatives and integrals)
  '\\dif': `\\mathrm d`,
  // Vector
  '\\vec': `{\\boldsymbol{#1}}`,
  // Matrix
  '\\mat': `{\\boldsymbol{#1}}`,
  // Real line
  '\\reals': `{\\mathbb{R}}`,
  // Complex plane
  '\\comps': `{\\mathbb{C}}`,
  // Integers
  '\\ints': `{\\mathbb{Z}}`,
  // Expectation value
  '\\expec': `\\mathbb{E}`,
  // Variance
  '\\var': `\\operatorname{var}`,
  // Matrix diagonal
  '\\diag': `\\operatorname{diag}`,
  // Unit/identity matrix
  '\\unity': `\\mat{\\mathbb{I}}`,
  // Used in equations to hide non-essential constants
  '\\const': `\\text{const}`,
  // Absolute value
  '\\abs': `\\left|#1\\right|`,
  // Adaptive parentheses
  '\\paren': `\\mathopen{}\\left(#1\\right)\\mathclose{}`,
  // Adaptive brackets
  '\\brkt': `\\mathopen{}\\left[#1\\right]\\mathclose{}`,
  // Adaptive curly brackets
  '\\cbrkt': `\\mathopen{}\\left\\{#1\\right\\}\\mathclose{}`,
}

for (let index = `A`.charCodeAt(); index <= `Z`.charCodeAt(); index++) {
  const letter = String.fromCharCode(index)
  // Caligraphic letters
  macros[`\\${letter}cal`] = `\\mathcal{${letter}}`
  // Blackboard bold letters
  macros[`\\${letter}bb`] = `\\mathbb{${letter}}`
}

module.exports = macros

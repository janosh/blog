const macros = {
  '\\dif': `\\mathrm d`,
  '\\vec': `{\\boldsymbol{#1}}`,
  '\\mat': `{\\boldsymbol{#1}}`,
  '\\reals': `{\\mathbb{R}}`,
  '\\comps': `{\\mathbb{C}}`,
  '\\ints': `{\\mathbb{Z}}`,
  '\\expec': `\\mathbb{E}`,
  '\\varexpec': `\\langle #1\\rangle`,
  '\\var': `\\operatorname{var}`,
}

for (let index = `A`.charCodeAt(); index <= `Z`.charCodeAt(); index++) {
  const letter = String.fromCharCode(index)
  macros[`\\${letter}cal`] = `\\mathcal{${letter}}`
  macros[`\\${letter}bb`] = `\\mathbb{${letter}}`
}

module.exports = macros

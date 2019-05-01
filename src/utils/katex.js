const macros = {
  '\\dif': `\\mathrm d`,
  '\\vec': `{\\boldsymbol{#1}}`,
  '\\mat': `{\\boldsymbol{#1}}`,
  '\\reals': `{\\mathbb{R}}`,
  '\\comps': `{\\mathbb{C}}`,
  '\\ints': `{\\mathbb{Z}}`,
  '\\expec': `\\mathbb{E}`,
  '\\varexpec': `\\langle #1\\rangle`,
}

for (let i = `A`.charCodeAt(); i <= `Z`.charCodeAt(); i++) {
  const letter = String.fromCharCode(i)
  macros[`\\${letter}cal`] = `\\mathcal{${letter}}`
  macros[`\\${letter}bb`] = `\\mathbb{${letter}}`
}

module.exports = macros

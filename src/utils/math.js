export const range = (min, max, step = 1) => {
  if (!max && min > 0) [min, max] = [0, min]
  const arr = []
  while (min < max) arr.push((min += step) - step)
  return arr
}

export const multivariateNormalDiag = (mu, sigma) => {
  if (mu.length !== sigma.length)
    throw new Error(`dimension mismatch in multivariateNormalDiag()`)
  const Z = ((2 * Math.PI) ** mu.length * sigma.reduce((a, b) => a * b)) ** -0.5
  return x => {
    const diff = x.map((xi, idx) => xi - mu[idx])
    const exp = -0.5 * sigma.reduce((acc, si, idx) => acc + diff[idx] ** 2 / si, 0)
    return Z * Math.exp(exp)
  }
}

// Compute the determinant of a regular JS array.
// Adapted from https://stackoverflow.com/a/57696101.
export const arrDet = mat => {
  if (mat.length == 1) return mat[0][0]
  if (mat.length == 2) return mat[0][0] * mat[1][1] - mat[0][1] * mat[1][0]
  return mat[0].reduce(
    (acc, el, idx) =>
      acc +
      (-1) ** (idx + 2) *
        el *
        arrDet(mat.slice(1).map(c => c.filter((_, j) => idx != j))),
    0
  )
}

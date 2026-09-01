// Bayes: p(H|E) = p(E|H) p(H) / [p(E|H) p(H) + p(E|¬H) p(¬H)], i.e. the share of the
// evidence area (both bottom rectangles) that lies inside the hypothesis rectangle.
// All probabilities are in percent.
export function posterior_pct(
  p_h: number,
  p_e_given_h: number,
  p_e_given_not_h: number,
): number {
  const p_evidence = p_e_given_h * p_h + p_e_given_not_h * (100 - p_h)
  // no evidence area means p(H|E) is undefined, show 0 instead of NaN
  return p_evidence === 0 ? 0 : (100 * p_e_given_h * p_h) / p_evidence
}

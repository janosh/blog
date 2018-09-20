const [points, middle] = [51, 25]
const range = Array.from(Array(points), (e, i) => 0.5 * (i - middle))
const z = range.map(x =>
  range.map(
    y =>
      Math.exp(-0.05 * (x ** 2 + y ** 2)) +
      0.7 * Math.exp(-0.1 * ((x - 10) ** 2 + y ** 2)) +
      0.5 * Math.exp(-0.1 * ((x + 7) ** 2 + (y - 7) ** 2))
  )
)

export default {
  data: [
    {
      z,
      x: range,
      y: range,
      type: `surface`,
      contours: {
        z: {
          show: true,
          usecolormap: true,
          highlightcolor: `white`,
          project: { z: true },
        },
      },
      showscale: false,
    },
  ],
  style: { height: `30em` },
}

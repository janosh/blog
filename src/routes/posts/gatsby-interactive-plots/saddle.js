const [points, middle] = [21, 10]
const range = Array.from(Array(points), (_itm, idx) => idx - middle)
const z = range.map((x) => range.map((y) => x * x - y * y))

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
    },
  ],
  style: { height: `30em` },
}

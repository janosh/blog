<script>
  export let parent_width
  export let parent_height
  export let width = 50
  export let height = 50
  export let pos = `top: 0; left: 0;`
  export let handle_position = `top: 0; left: 0;`

  export let color
  export let resizable = `xy` // `x`, `y` or `xy`

  let resize_initial_x, resize_initial_y

  let initial_width, initial_height

  function resizePointerDown(event) {
    event.stopPropagation()
    resize_initial_x = event.pageX
    resize_initial_y = event.pageY

    initial_width = width
    initial_height = height

    window.addEventListener(`pointermove`, resizePointerMove)
    window.addEventListener(`pointerup`, resizePointerUp)
    window.addEventListener(`pointercancel`, resizePointerUp)
  }

  function resizePointerMove(event) {
    let dirX = pos.includes(`right`) ? -1 : 1
    let dirY = pos.includes(`bottom`) ? -1 : 1
    let scaleX = parent_width / 100
    let scaleY = parent_height / 100
    if (resizable.includes(`x`)) {
      let newWidth =
        (initial_width * dirX + (event.pageX - resize_initial_x) / scaleX) * dirX
      width = Math.min(100, Math.max(0, newWidth)) // prevent extending beyond container
    }
    if (resizable.includes(`y`)) {
      let newHeight =
        (initial_height * dirY + (event.pageY - resize_initial_y) / scaleY) * dirY
      height = Math.min(100, Math.max(0, newHeight)) // prevent extending beyond container
    }
  }

  function resizePointerUp() {
    window.removeEventListener(`pointermove`, resizePointerMove)
    window.removeEventListener(`pointerup`, resizePointerUp)
    window.removeEventListener(`pointercancel`, resizePointerUp)
  }
</script>

<div
  class="resizable"
  style="{pos} width: {width}%; height:{height}%; background: {color};"
>
  <slot />
  <div class="resizer" on:pointerdown={resizePointerDown} style={handle_position} />
</div>

<style>
  .resizable {
    touch-action: none;
    position: absolute;
    will-change: transform;
    /* use box-shadow instead of border to achieve border collapse: https://stackoverflow.com/a/28807765 */
    box-shadow: 2px 0 0 0 white, 0 2px 0 0 white, 2px 0 0 0 white inset,
      0 2px 0 0 white inset;
  }
  .resizer {
    background-color: orange;
    border-radius: 50%;
    border: 2px solid white;
    bottom: 0;
    box-sizing: border-box;
    cursor: pointer; /* consider using 'nw-resize' and friends */
    height: calc(1ex + 2vw);
    max-height: 2ex;
    max-width: 2ex;
    position: absolute;
    right: 0;
    transform: translate(-50%, -50%);
    user-select: none;
    width: calc(1ex + 2vw);
  }
</style>

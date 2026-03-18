<script lang="ts">
  import type { Snippet } from 'svelte'
  import type { HTMLAttributes } from 'svelte/elements'

  let {
    parent_width,
    parent_height,
    width = $bindable(50),
    height = $bindable(50),
    pos = `top: 0; left: 0;`,
    handle_position = `top: 0; left: 0;`,
    color,
    resizable = `xy`,
    children,
  }: {
    parent_width: number
    parent_height: number
    width?: number
    height?: number
    pos?: string
    handle_position?: string
    color: string
    resizable?: `x` | `y` | `xy`
    children?: Snippet<[]>
  } & HTMLAttributes<HTMLDivElement> = $props()

  let resize = $state({ x: 0, y: 0 })
  let size = $state({ width, height })

  function pointer_down(event: PointerEvent) {
    event.stopPropagation()
    resize.x = event.pageX
    resize.y = event.pageY
    size.width = width
    size.height = height
    globalThis.addEventListener(`pointermove`, pointer_move)
    globalThis.addEventListener(`pointerup`, pointer_up)
    globalThis.addEventListener(`pointercancel`, pointer_up)
  }

  function pointer_move(event: PointerEvent) {
    const dir_x = pos.includes(`right`) ? -1 : 1
    const dir_y = pos.includes(`bottom`) ? -1 : 1
    if (resizable.includes(`x`)) {
      const new_width = (size.width * dir_x + (event.pageX - resize.x) / (parent_width / 100)) * dir_x
      width = Math.min(100, Math.max(0, new_width))
    }
    if (resizable.includes(`y`)) {
      const new_height = (size.height * dir_y + (event.pageY - resize.y) / (parent_height / 100)) * dir_y
      height = Math.min(100, Math.max(0, new_height))
    }
  }

  function pointer_up() {
    globalThis.removeEventListener(`pointermove`, pointer_move)
    globalThis.removeEventListener(`pointerup`, pointer_up)
    globalThis.removeEventListener(`pointercancel`, pointer_up)
  }
  let style = $derived(
    `${pos} width: ${width}%; height:${height}%; background: ${color};`,
  )
</script>

<div class="resizable" {style}>
  {@render children?.()}
  <div class="resizer" role="separator" onpointerdown={pointer_down} style={handle_position}></div>
</div>

<style>
  .resizable {
    touch-action: none;
    position: absolute;
    will-change: transform;
    /* use box-shadow instead of border to achieve border collapse: https://stackoverflow.com/a/28807765 */
    box-shadow:
      2px 0 0 0 white,
      0 2px 0 0 white,
      2px 0 0 0 white inset,
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

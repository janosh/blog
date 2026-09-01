<script lang="ts">
  import { untrack } from 'svelte'
  import type { Attachment } from 'svelte/attachments'
  import { resizable } from 'svelte-widgets/attachments'

  let {
    probability = $bindable(),
    size,
    dimension,
    label,
    style,
    label_style,
  }: {
    probability: number
    size: { width: number; height: number }
    dimension: 'width' | 'height'
    label: string
    style: string
    label_style: string
  } = $props()
  const initial = untrack(() => probability)
  const resize: Attachment<HTMLDivElement> = (node) =>
    resizable({
      edges: [dimension === `width` ? `right` : `top`],
      min_width: 0,
      min_height: 0,
      max_width: () => size.width,
      max_height: () => size.height,
      on_resize: (_event, dimensions) => {
        probability = (dimensions[dimension] / size[dimension]) * 100
        // Restore percentage sizing and the bottom anchor after pixel-based resizing.
        node.style[dimension] = `${probability}%`
        if (dimension === `height`) node.style.removeProperty(`top`)
      },
      on_resize_reset: () => {
        probability = initial
        node.style[dimension] = `${initial}%`
      },
    })(node)
</script>

<div class="resizable" {style} {@attach resize}>
  <span style={label_style}>{label} = {Math.round(probability)}%</span>
</div>

<style>
  span {
    position: absolute;
    white-space: nowrap;
    font-size: clamp(0.75rem, 2.5vw, 1rem);
  }
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
    :global([data-resize-edge]) {
      background: orange;
      border: 1px solid white;
      border-radius: 3px;
      opacity: 0.7;
    }
  }
</style>

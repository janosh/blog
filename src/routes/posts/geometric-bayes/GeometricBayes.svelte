<script lang="ts">
  import { FullscreenButton } from 'svelte-widgets'
  import { posterior_pct } from './bayes'
  import ProbabilityRegion from './ProbabilityRegion.svelte'

  let size = $state({ width: 0, height: 0 })
  let container: HTMLDivElement | undefined = $state()
  let p_h = $state(20)
  let p_e_given_h = $state(40)
  let p_e_given_not_h = $state(20)
  const posterior = $derived(posterior_pct(p_h, p_e_given_h, p_e_given_not_h))
</script>

<div
  id="container"
  bind:this={container}
  bind:clientHeight={size.height}
  bind:clientWidth={size.width}
>
  <FullscreenButton placement="corner" wrapper={container} />
  {#if size.width && size.height}
    <ProbabilityRegion
      {size}
      dimension="width"
      bind:probability={p_h}
      label="p(H)"
      style="top: 0; left: 0; width: {p_h}%; height: {100 -
        p_e_given_h}%; background: teal"
      label_style="left: 50%; top: 0; transform: translate(-50%, calc(-100% - 1ex))"
    />
    <ProbabilityRegion
      {size}
      dimension="height"
      bind:probability={p_e_given_h}
      label="p(E|H)"
      style="bottom: 0; left: 0; width: {p_h}%; height: {p_e_given_h}%; background: DeepSkyBlue"
      label_style="left: 0; top: 50%; transform: translate(calc(-100% - 1ex), -50%)"
    />
    <ProbabilityRegion
      {size}
      dimension="height"
      bind:probability={p_e_given_not_h}
      label="p(E|¬H)"
      style="bottom: 0; right: 0; width: {100 -
        p_h}%; height: {p_e_given_not_h}%; background: SteelBlue"
      label_style="right: 0; top: 50%; transform: translate(calc(100% + 1ex), -50%)"
    />
  {/if}
</div>
<div id="result" style:width="{size.width}px">
  <div style:width="{posterior}%">
    <span style="right: 50%; bottom: 0; transform: translate(50%, calc(100% + 1ex))">
      p(H|E) =
      {Math.round(posterior)}%
    </span>
  </div>
</div>

<style>
  #container {
    position: relative;
    background: #434343;
    --fullscreen-btn-bg: #0007;
    --fullscreen-btn-color: white;
    --fullscreen-btn-opacity: 0.85;
    width: min(50vw, calc(100vw - 13rem));
    height: min(50vw, calc(100vw - 13rem));
    max-height: 600px;
    max-width: 600px;
    margin: 3em auto;
    box-shadow:
      2px 0 0 0 white,
      0 2px 0 0 white,
      2px 2px 0 0 white,
      2px 0 0 0 white inset,
      0 2px 0 0 white inset;
  }
  span {
    position: absolute;
    white-space: nowrap;
    font-size: clamp(0.75rem, 2.5vw, 1rem);
  }
  #result {
    margin: auto;
    height: 100px;
    box-sizing: border-box;
    background: SteelBlue;
    border: 2px solid white;
  }
  #result div {
    background: DeepSkyBlue;
    height: 100%;
    border-right: 2px solid white;
    position: relative;
  }
</style>

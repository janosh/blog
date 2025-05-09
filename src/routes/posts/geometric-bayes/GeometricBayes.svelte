<script>
  import Resizable from './Resizable.svelte'

  let [parent_height, parent_width] = $state([0, 0])

  // geometric Bayes state
  let [pH, pEGivenH, pEGivenNotH] = $state([20, 40, 20])
  // derived state
  let pNotH = $derived(100 - pH)
  let pNotEGivenH = $derived(100 - pEGivenH)
  let pHGivenE = $derived((pEGivenH * pH) / (pEGivenH + pEGivenNotH))
</script>

<div id="container" bind:clientHeight={parent_height} bind:clientWidth={parent_width}>
  {#if parent_height && parent_width}
    <Resizable
      {parent_height}
      {parent_width}
      bind:width={pH}
      bind:height={pNotEGivenH}
      color="teal"
      resizable="x"
      handle_position="top: 0%; left: 100%"
    >
      <span style="left: 50%; top: 0; transform: translate(-50%, calc(-100% - 1ex));">
        p(H) =
        {Math.round(pH)}%
      </span>
    </Resizable>
    <Resizable
      {parent_height}
      {parent_width}
      bind:width={pH}
      bind:height={pEGivenH}
      color="DeepSkyBlue"
      resizable="y"
      pos="bottom: 0; left: 0;"
    >
      <span style="left: 0; top: 50%; transform: translate(calc(-100% - 1ex), -50%);">
        p(E|H) =
        {Math.round(pEGivenH)}%
      </span>
    </Resizable>
    <Resizable
      {parent_height}
      {parent_width}
      bind:width={pNotH}
      bind:height={pEGivenNotH}
      color="SteelBlue"
      resizable="y"
      pos="bottom: 0; right: 0;"
      handle_position="top: 0%; left: 100%"
    >
      <span style="right: 0; top: 50%; transform: translate(calc(100% + 1ex), -50%);">
        p(E|&not;H) =
        {Math.round(pEGivenNotH)}%
      </span>
    </Resizable>
  {/if}
</div>
<div id="result" style="width: {parent_width}px">
  <div style="width: {pHGivenE}%;">
    <span style="right: 50%; bottom: 0; transform: translate(50%, calc(100% + 1ex));">
      p(H|E) =
      {Math.round(pHGivenE)}%
    </span>
  </div>
</div>

<style>
  #container {
    background: #434343;
    width: 50vw;
    height: 50vw;
    max-height: 600px;
    max-width: 600px;
    margin: 3em auto;
    box-shadow:
      2px 0 0 0 white,
      0 2px 0 0 white,
      2px 2px 0 0 white,
      /* Just to fix the corner */ 2px 0 0 0 white inset,
      0 2px 0 0 white inset;
  }
  span {
    position: absolute;
    white-space: nowrap;
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

<main>
  <slot />
</main>

<style>
  main {
    margin: 2em auto;
    max-width: 40em;
    background-color: whitesmoke;
    color: black;
    padding: 3em;
    display: grid;
    gap: 0 1em;
    grid-template-columns: 1fr 140px;
  }
  main :global(a) {
    color: darkblue;
  }
  main :global(code) {
    padding: 0 !important;
  }
</style>

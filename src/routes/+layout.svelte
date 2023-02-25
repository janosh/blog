<script lang="ts">
  import { page } from '$app/stores'
  import { Footer } from '$lib'
  import '../app.css'
</script>

{#if $page.url.pathname !== `/`}
  <a href="/" aria-label="Back to index page">&laquo; home</a>
{/if}

<slot />

<Footer />

<style>
  a[href='/'] {
    font-size: 15pt;
    position: absolute;
    top: 2em;
    left: 2em;
    background-color: rgba(0, 0, 0, 0.5);
    padding: 1pt 5pt;
    border-radius: 3pt;
    transition: 0.2s;
  }
</style>

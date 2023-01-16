<script lang="ts">
  import { Footer } from '$lib'
  import '../app.css'

  // const routes = Object.keys(import.meta.glob(`./*/+page*.{svx,md,svelte}`)).map(
  //   (filename) => filename.split(`/`)[1]
  // )
</script>

<!-- <Nav {routes} /> -->

<slot />

<Footer />

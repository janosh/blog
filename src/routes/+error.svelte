<script lang="ts">
  import { page } from '$app/state'
  import { bugs, name } from '#root/package.json'
  import { ErrorPage } from 'svelte-widgets'
</script>

<ErrorPage
  status={page.status}
  message={page.error?.message}
  {name}
  bugs_url={bugs}
  status_page_url="https://githubstatus.com"
/>

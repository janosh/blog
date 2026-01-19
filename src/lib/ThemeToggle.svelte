<script lang="ts">
  import Icon from '@iconify/svelte'
  import { onMount } from 'svelte'

  let theme: `light` | `dark` = $state(`dark`)

  onMount(() => {
    theme = (localStorage.getItem(`theme`) as `light` | `dark`) ||
      (window.matchMedia(`(prefers-color-scheme: dark)`).matches ? `dark` : `light`)
    document.documentElement.style.colorScheme = theme
  })

  function toggle_theme(): void {
    theme = ({ light: `dark`, dark: `light` } as const)[theme]
    document.documentElement.style.colorScheme = theme
    localStorage.setItem(`theme`, theme)
  }
</script>

<button onclick={toggle_theme} title="Switch to {theme} theme">
  <Icon icon={{ light: `ph:sun-bold`, dark: `ph:moon-bold` }[theme]} />
</button>

<style>
  button {
    position: fixed;
    top: clamp(9pt, 2vw, 1.5em);
    right: clamp(9pt, 2vw, 1.5em);
    background: var(--card-bg);
    color: var(--text-color);
    border: 1px solid var(--card-border);
    box-sizing: border-box;
    width: 32pt;
    height: 32pt;
    border-radius: 50%;
    display: flex;
    place-items: center;
    place-content: center;
    box-shadow: 0 2px 8px var(--shadow);
    transition: transform 0.2s, box-shadow 0.2s;
  }
  button:hover {
    transform: scale(1.1);
    box-shadow: 0 4px 12px var(--shadow);
  }
  @media print {
    button {
      display: none;
    }
  }
</style>

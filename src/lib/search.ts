import { goto } from '$app/navigation'
import { site_routes } from '$lib'
import type { CmdAction } from 'svelte-widgets'
import { apply_theme_mode } from 'svelte-widgets/theme'

const themes = [
  [`light`, `🌞 Light theme`],
  [`dark`, `🌙 Dark theme`],
  [`system`, `🖥️ System theme`],
] as const

export const search_actions: CmdAction[] = [
  ...site_routes.map((route) => ({
    id: `route:${route}`,
    label: route,
    action: () => goto(route),
  })),
  ...themes.map(([mode, label]) => ({
    id: `theme:${mode}`,
    label,
    action: () => apply_theme_mode(mode),
  })),
]

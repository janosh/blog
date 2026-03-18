<script lang="ts">
  import type { Reference } from '$lib/types'
  import { onMount } from 'svelte'
  import type { HTMLAttributes } from 'svelte/elements'
  import { tooltip } from 'svelte-multiselect/attachments'

  let { papers, hovered_ids = $bindable([]), ...rest }: HTMLAttributes<HTMLDivElement> & {
    papers: Reference[]
    hovered_ids?: string[]
  } = $props()

  interface WeekData {
    year: number
    week: number
    papers: Reference[]
    count: number
    date: Date
  }
  let grid_data: WeekData[][] = $state([])
  let years: number[] = $state([])
  let max_count = $state(0)

  onMount(() => {
    const papers_by_week = new Map<string, Reference[]>()

    for (const paper of papers) {
      const issued = paper.issued?.[0]
      if (!issued?.year) continue

      const date = new Date(issued.year, (issued.month || 1) - 1, issued.day || 1)
      const key = `${date.getFullYear()}-${get_week_number(date)}`

      const existing = papers_by_week.get(key)
      if (existing) existing.push(paper)
      else papers_by_week.set(key, [paper])
    }

    const all_years = Array.from(papers_by_week.keys()).map((key) =>
      parseInt(key.split(`-`)[0], 10)
    )
    const [min_year, max_year] = [Math.min(...all_years), Math.max(...all_years)]
    years = Array.from({ length: max_year - min_year + 1 }, (_, idx) => min_year + idx)

    max_count = Math.max(...Array.from(papers_by_week.values()).map((p) => p.length))

    grid_data = years.map((year) =>
      Array.from({ length: 52 }, (_, week) => {
        const key = `${year}-${week + 1}`
        const week_papers = papers_by_week.get(key) ?? []
        const date = new Date(year, 0, 1 + (week * 7))
        return { year, week: week + 1, papers: week_papers, count: week_papers.length, date }
      })
    )
  })

  function get_week_number(date: Date): number {
    const start = new Date(date.getFullYear(), 0, 1)
    const days = Math.floor((date.getTime() - start.getTime()) / (24 * 60 * 60 * 1000))
    return Math.ceil((days + start.getDay() + 1) / 7)
  }

  function get_color(count: number): string {
    if (count === 0) return `var(--nav-bg)`
    const intensity = Math.min(count / max_count, 1)
    return `hsl(200, 70%, ${85 - intensity * 50}%)`
  }

  function format_tip(week: WeekData): string {
    const start = new Date(week.date)
    const end = new Date(start.getTime() + 6 * 24 * 60 * 60 * 1000)
    const range = `${start.toLocaleDateString(`en-US`, { month: `short`, day: `numeric` })} - ${end.toLocaleDateString(`en-US`, { month: `short`, day: `numeric` })}, ${week.year}`
    if (week.count === 0) return `W${week.week} - ${range}`
    const items = week.papers.map((paper, idx) => {
      const authors = paper.author?.slice(0, 3).map((auth) => `${auth.given} ${auth.family}`).join(`, `) ?? ``
      const et_al = paper.author && paper.author.length > 3 ? ` et al.` : ``
      return `${idx + 1}. ${paper.title}<br><small>${authors}${et_al}</small>`
    }).join(`<br>`)
    return `${range}<br>${items}`
  }
</script>

<div {...rest} class="graph-container {rest.class ?? ``}">
  <div class="year-labels">
    {#each years as year (year)}
      <div class="year-label">{year}</div>
    {/each}
  </div>

  <div class="weeks-grid">
    {#each grid_data as year_data, year_idx (year_idx)}
      <div class="year-row">
        {#each year_data as week_data (JSON.stringify(week_data))}
          <div
            class="week-tile"
            role="gridcell"
            tabindex="-1"
            style:background-color={get_color(week_data.count)}
            {@attach tooltip({ content: format_tip(week_data) })}
            onmouseenter={() => hovered_ids = week_data.papers.map((p) => p.id)}
            onmouseleave={() => hovered_ids = []}
          >
          </div>
        {/each}
      </div>
    {/each}
  </div>
</div>

<style>
  .graph-container {
    position: relative;
    display: flex;
    gap: 8px;
    width: 100%;
    margin: 20px 0;
  }
  .year-labels {
    transform: translateY(-4px);
    display: grid;
  }
  .year-label {
    flex: 1;
    font-size: 10px;
    color: var(--text-secondary);
    display: flex;
    align-items: center;
    padding-right: 4px;
  }
  .weeks-grid {
    display: flex;
    flex-direction: column;
    gap: 4px;
    flex: 1;
  }
  .year-row {
    display: flex;
    gap: 4px;
  }
  .week-tile {
    flex: 1;
    aspect-ratio: 1;
    min-width: 0;
    border-radius: 3px;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  .week-tile:hover {
    transform: scale(1.1);
    box-shadow: 0 0 3px var(--shadow);
  }
</style>

<script lang="ts">
  import type { Reference } from '$lib/types'
  import { onMount } from 'svelte'

  interface Props {
    papers: Reference[]
    [key: string]: unknown
  }
  let { papers, ...rest }: Props = $props()

  interface WeekData {
    year: number
    week: number
    papers: Reference[]
    count: number
    date: Date
  }

  let grid_data: WeekData[][] = $state([])
  let years: number[] = $state([])
  let tooltip: { data: WeekData | null; x: number; y: number } = $state({
    data: null,
    x: 0,
    y: 0,
  })
  let max_count = $state(0)

  onMount(() => {
    const papers_by_week = new Map<string, Reference[]>()

    papers.forEach((paper) => {
      const issued = paper.issued?.[0]
      if (!issued?.year) return

      const date = new Date(issued.year, (issued.month || 1) - 1, issued.day || 1)
      const key = `${date.getFullYear()}-${get_week_number(date)}`

      if (!papers_by_week.has(key)) papers_by_week.set(key, [])
      papers_by_week.get(key)!.push(paper)
    })

    const all_years = Array.from(papers_by_week.keys()).map((key) =>
      parseInt(key.split(`-`)[0])
    )
    const [min_year, max_year] = [Math.min(...all_years), Math.max(...all_years)]
    years = Array.from({ length: max_year - min_year + 1 }, (_, i) => min_year + i)

    max_count = Math.max(...Array.from(papers_by_week.values()).map((p) => p.length))

    grid_data = years.map((year) =>
      Array.from({ length: 52 }, (_, week) => {
        const key = `${year}-${week + 1}`
        const week_papers = papers_by_week.get(key) || []
        const date = new Date(year, 0, 1 + (week * 7))

        return {
          year,
          week: week + 1,
          papers: week_papers,
          count: week_papers.length,
          date,
        }
      })
    )
  })

  function get_week_number(date: Date): number {
    const start = new Date(date.getFullYear(), 0, 1)
    const days = Math.floor(
      (date.getTime() - start.getTime()) / (24 * 60 * 60 * 1000),
    )
    return Math.ceil((days + start.getDay() + 1) / 7)
  }

  function get_color(count: number): string {
    if (count === 0) return `#ebedf0`
    const intensity = Math.min(count / max_count, 1)
    return `hsl(200, 70%, ${85 - intensity * 50}%)`
  }

  function handle_hover(event: MouseEvent, week?: WeekData) {
    tooltip = week
      ? { data: week, x: event.clientX, y: event.clientY }
      : { data: null, x: 0, y: 0 }
  }

  function format_week(week: WeekData): string {
    const start = new Date(week.date)
    const end = new Date(start.getTime() + 6 * 24 * 60 * 60 * 1000)
    return `${
      start.toLocaleDateString(`en-US`, { month: `short`, day: `numeric` })
    } - ${
      end.toLocaleDateString(`en-US`, { month: `short`, day: `numeric` })
    }, ${week.year}`
  }
</script>

<div {...rest} class="graph-container {rest.class ?? ``}">
  <div class="legend">
    <span>Less</span>
    <div class="legend-tiles">
      {#each [0, 0.25, 0.5, 0.75, 1] as intensity (intensity)}
        <div class="legend-tile" style:background-color={get_color(intensity)}></div>
      {/each}
    </div>
    <span>More</span>
  </div>

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
            style:background-color={get_color(week_data.count)}
            role="button"
            tabindex="0"
            onmouseenter={(e) => handle_hover(e, week_data)}
            onmouseleave={() => handle_hover(new MouseEvent(`mouseleave`))}
            onmousemove={(e) => tooltip.data && handle_hover(e, week_data)}
          >
          </div>
        {/each}
      </div>
    {/each}
  </div>
</div>

{#if tooltip.data}
  <div class="tooltip" style:left="{tooltip.x + 10}px" style:top="{tooltip.y - 10}px">
    {#if tooltip.data.count === 0}
      <div class="tooltip-header empty-week">
        <strong>W{tooltip.data.week}</strong> - {format_week(tooltip.data)}
      </div>
    {:else}
      <div class="tooltip-header">
        <strong>{tooltip.data.count} publication{
            tooltip.data.count !== 1 ? `s` : ``
          }</strong>
        <div class="tooltip-date">{format_week(tooltip.data)}</div>
      </div>
      {#each tooltip.data.papers as paper (paper.id)}
        <div class="tooltip-paper">
          <div class="paper-title">{paper.title}</div>
          <div class="paper-authors">
            {
              paper.author?.slice(0, 3).map((a) => `${a.given} ${a.family}`).join(
                `, `,
              )
            }
            {#if paper.author && paper.author.length > 3}et al.{/if}
          </div>
        </div>
      {/each}
    {/if}
  </div>
{/if}

<style>
  .graph-container {
    position: relative;
    display: flex;
    gap: 8px;
    width: 100%;
    margin: 20px 0;
  }
  .legend {
    position: absolute;
    top: -25px;
    right: 0;
    display: flex;
    align-items: center;
    gap: 4px;
    font-size: 12px;
    color: #666;
  }
  .legend-tiles {
    display: flex;
    gap: 4px;
  }
  .legend-tile {
    width: 14px;
    height: 14px;
    border-radius: 3px;
  }
  .year-labels {
    transform: translateY(-4px);
    display: grid;
  }
  .year-label {
    flex: 1;
    font-size: 10px;
    color: #666;
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
    box-shadow: 0 0 3px rgba(0, 0, 0, 0.3);
  }
  .tooltip {
    position: fixed;
    background: white;
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 6px 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    z-index: 1000;
    max-width: 300px;
    pointer-events: none;
    font-size: 14px;
  }
  .tooltip-header {
    border-bottom: 1px solid #eee;
  }
  .tooltip-header.empty-week {
    border-bottom: none;
  }
  .tooltip-date {
    font-size: 12px;
    color: #666;
  }
  .tooltip-paper {
    border-bottom: 1px solid #f0f0f0;
  }
  .tooltip-paper:last-child {
    border-bottom: none;
  }
  .paper-title {
    font-size: 12px;
    font-weight: 500;
    color: #333;
  }
  .paper-authors {
    font-size: 11px;
    color: #666;
  }
</style>

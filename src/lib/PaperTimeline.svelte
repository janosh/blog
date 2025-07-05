<script lang="ts">
  import type { Reference } from '$lib/types'
  import { onMount } from 'svelte'

  interface Props {
    papers: Reference[]
    [key: string]: unknown
  }
  let { papers, ...rest }: Props = $props()

  interface TimelineData {
    paper: Reference
    date: Date
    position: number
    title: string
    authors: string
    journal: string
    year: number
  }

  let timeline_data: TimelineData[] = $state([])
  let date_range: { min: Date; max: Date } = $state({
    min: new Date(),
    max: new Date(),
  })
  let tooltip: { data: TimelineData | null; x: number; y: number } = $state({
    data: null,
    x: 0,
    y: 0,
  })

  onMount(() => {
    const parsed_papers = papers
      .map((paper) => {
        const issued = paper.issued?.[0]
        if (!issued?.year) return null

        const date = new Date(issued.year, (issued.month || 1) - 1, issued.day || 1)
        const authors = paper.author?.map((a) =>
          `${a.given} ${a.family}`
        ).join(`, `) || `Unknown`

        return {
          paper,
          date,
          position: 0,
          title: paper.title || `Untitled`,
          authors,
          journal: paper[`container-title`] || `Unknown Journal`,
          year: issued.year,
        }
      })
      .filter(Boolean) as TimelineData[]

    if (parsed_papers.length === 0) return

    const dates = parsed_papers.map((p) => p.date)
    date_range = {
      min: new Date(Math.min(...dates.map((d) => d.getTime()))),
      max: new Date(Math.max(...dates.map((d) => d.getTime()))),
    }

    const time_range = date_range.max.getTime() - date_range.min.getTime()
    parsed_papers.forEach((paper) => {
      paper.position =
        ((paper.date.getTime() - date_range.min.getTime()) / time_range) * 100
    })

    timeline_data = parsed_papers.sort((a, b) => a.date.getTime() - b.date.getTime())
  })

  function handle_hover(event: MouseEvent, paper?: TimelineData) {
    tooltip = paper
      ? { data: paper, x: event.clientX, y: event.clientY }
      : { data: null, x: 0, y: 0 }
  }

  function format_authors(authors: string): string {
    const list = authors.split(`, `)
    return list.length <= 3 ? authors : `${list.slice(0, 3).join(`, `)} et al.`
  }
</script>

<div {...rest} class="timeline-line {rest.class ?? ``}">
  {#each timeline_data as paper_data (paper_data.paper.id)}
    <div
      class="timeline-marker"
      style:left="{paper_data.position}%"
      role="button"
      tabindex="0"
      onmouseenter={(e) => handle_hover(e, paper_data)}
      onmouseleave={() => handle_hover(new MouseEvent(`mouseleave`))}
      onmousemove={(e) => tooltip.data && handle_hover(e, paper_data)}
    >
      <div class="marker-bar"></div>
      <div class="marker-year">{paper_data.year}</div>
    </div>
  {/each}
</div>

{#if tooltip.data}
  <div class="tooltip" style:left="{tooltip.x + 10}px" style:top="{tooltip.y - 10}px">
    <div class="tooltip-title">{tooltip.data.title}</div>
    <div class="tooltip-authors">{format_authors(tooltip.data.authors)}</div>
    <div class="tooltip-journal">{tooltip.data.journal}</div>
    <div class="tooltip-date">
      {
        tooltip.data.date.toLocaleDateString(`en-US`, {
          year: `numeric`,
          month: `long`,
          day: `numeric`,
        })
      }
    </div>
  </div>
{/if}

<style>
  .timeline-line {
    position: relative;
    width: 100%;
    margin: 30px 15px 40px;
    height: 2px;
    background: #ddd;
  }
  .timeline-marker {
    position: absolute;
    top: -15px;
    transform: translateX(-50%);
    cursor: pointer;
    transition: transform 0.2s ease;
  }
  .timeline-marker:hover {
    transform: translateX(-50%) scale(1.1);
  }
  .marker-bar {
    width: 3px;
    height: 30px;
    background: #3a57d7;
    margin: 0 auto;
    border-radius: 1px;
    transition: all 0.2s ease;
  }
  .timeline-marker:hover .marker-bar {
    background: #2a47c7;
    height: 35px;
  }
  .marker-year {
    font-size: 10px;
    text-align: center;
    margin-top: 5px;
    color: #666;
    font-weight: 500;
  }
  .tooltip {
    position: fixed;
    background: white;
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    z-index: 1000;
    max-width: 300px;
    pointer-events: none;
  }
  .tooltip-title {
    font-weight: 600;
    font-size: 14px;
    margin-bottom: 6px;
    color: #333;
  }
  .tooltip-authors {
    font-size: 12px;
    color: #666;
    margin-bottom: 4px;
  }
  .tooltip-journal {
    font-size: 12px;
    color: #888;
    font-style: italic;
    margin-bottom: 4px;
  }
  .tooltip-date {
    font-size: 11px;
    color: #aaa;
  }
</style>

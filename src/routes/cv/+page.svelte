<script lang="ts">
  import Icon from '@iconify/svelte'
  import cv from './cv-data.yml'

  const email = `janosh@lbl.gov`
  const links = { target: `_blank`, rel: `noreferrer` }

  const social: [string, string, string][] = [
    [email, `mailto:${email}`, `mdi:email`],
    [`janosh`, `https://github.com/janosh`, `octicon:mark-github`],
    [`jrib_`, `https://twitter.com/jrib_`, `fa-brands:twitter`],
    [`janosh`, `https://stackoverflow.com/u/4034025`, `mdi:stackoverflow`],
    // [`janosh-riebesell`, `https://linkedin.com/in/janosh-riebesell`, `bi:linkedin`],
  ]
  function truncate_authors(
    author_str: string,
    target_name: string,
    max_authors: number = 3
  ): string {
    const authors = author_str.split(`, `)
    const target_idx = authors.indexOf(target_name)

    if (authors.length <= max_authors) return author_str

    let truncated_authors = [authors[0], authors[target_idx], authors[authors.length - 1]]

    // Remove duplicates
    truncated_authors = [...new Set(truncated_authors)]

    // Fill remaining spots
    let i = 1 // Start from the second author
    while (truncated_authors.length < max_authors && i < authors.length - 1) {
      if (!truncated_authors.includes(authors[i])) {
        truncated_authors.splice(i, 0, authors[i])
      }
      i++
    }
    truncated_authors = truncated_authors.slice(0, max_authors)

    // Add ellipsis
    let truncated_str = truncated_authors[0]
    for (let j = 1; j < truncated_authors.length; j++) {
      if (
        authors.indexOf(truncated_authors[j]) -
          authors.indexOf(truncated_authors[j - 1]) >
        1
      ) {
        truncated_str += `, ...`
      }
      truncated_str += `, ${truncated_authors[j]}`
    }

    return truncated_str
  }
</script>

<section class="title">
  <h1>Janosh Riebesell</h1>

  <small>
    <a href="https://materialsproject.org/about/people">
      Materials Project Staff @ Lawrence Berkeley National Lab
    </a>
  </small>

  <address>
    {#each social as [name, url, icon]}
      <a href={url} {...links}><Icon inline {icon} />{name}</a>
    {/each}
  </address>
</section>

<section class="body">
  <small>
    I joined the Materials Project in early 2023 where I build high-throughput workflows
    for generating large DFT and ML potential datasets. I am a core maintainer of
    <a href="https://github.com/materialsproject/pymatgen">pymatgen</a>
    and enjoy building infrastructure around high-quality open source software that enables
    new capabilities in computational materials to scale.
  </small>
  <h2>
    <Icon inline icon="zondicons:education" />&nbsp; Education
  </h2>
  <ul>
    {#each cv.education as { title, thesis_title, date, href, uni }}
      <li>
        <h4>
          <a {href}>{title}</a>
          <small style="font-weight: 200;">{uni}{date ? ` &bull; ${date}` : ``}</small>
        </h4>
        <p>Thesis title: {thesis_title}</p>
      </li>
    {/each}
  </ul>

  <h2>
    <Icon inline icon="iconoir:journal" />&nbsp; Selected Publications
  </h2>
  <ul>
    {#each cv.publications as { title, authors, journal, date, url: href, arxiv }}
      {@const year = new Date(date).getFullYear()}
      <li>
        <h4>{title}</h4>
        <p>
          {truncate_authors(authors, `Janosh Riebesell`)} -
          <small><a href={arxiv} {...links}>{journal}</a></small>
          -
          <small
            >{year}
            {#if href}
              - <a {href}>{href}</a>
            {/if}
          </small>
        </p>
      </li>
    {/each}
  </ul>

  <h2>
    <Icon inline icon="ri:open-source-line" />&nbsp; Open Source
    <!-- <small>only lead dev repos</small> -->
  </h2>
  <ul>
    {#each cv.projects as { url, img_style, github, name, description, stars, logo }}
      {@const logo_url = logo ?? `${url}/favicon.svg`}
      <li>
        <h4>
          <a href={url ?? github} {...links}>
            <img src={logo_url} alt="{name} Logo" style={img_style} />
            {name}
          </a>
          <a href={github} {...links}>
            <Icon inline icon="octicon:mark-github" />
          </a>
          {#if stars}
            <a href="{github}/stargazers">
              <small>{stars} ⭐</small>
            </a>
          {/if}
        </h4>
        <p>{description}</p>
      </li>
    {/each}
  </ul>

  <h2>
    <Icon inline icon="mdi:trophy" />&nbsp; Awards
  </h2>
  <ul>
    {#each cv.awards as { name, description, date, href }}
      <li>
        <h4><a {href}>{name}</a></h4>
        <p>{description} <small>{date}</small></p>
      </li>
    {/each}
  </ul>

  <h2>
    <Icon inline icon="material-symbols:volunteer-activism" />&nbsp; Volunteer Work
  </h2>
  <ul>
    {#each cv.volunteer as { name, description, href, logo, role }}
      <li>
        <h4>
          <a {href}><img src={logo} alt={name} height="20" />{name}</a>
          <small style="font-weight: 200;">{role}</small>
        </h4>
        <p>{description}</p>
      </li>
    {/each}
  </ul>
</section>

<aside>
  <h3>
    <Icon inline icon="lucide:languages" />&nbsp; Languages
  </h3>
  <ul>
    {#each cv.languages as { name, level }}
      <li>
        {name}
        <Icon inline icon="carbon:skill-level-{level}" />
      </li>
    {/each}
  </ul>

  <h3>
    <Icon inline icon="mdi:earth" />&nbsp; Nationality
    <ul>
      {#each cv.nationality as nat}
        <li>{nat}</li>
      {/each}
    </ul>
  </h3>

  <h3>
    <Icon inline icon="carbon:skill-level-advanced" />&nbsp; Skills
  </h3>
  <ul class="skills">
    {#each cv.skills as { name, icon, score, href }}
      <!-- color based on score style="color: hsl({score * 20}, 100%, 40%)" -->
      <li style:font-weight={(score - 3) * 100}>
        <a {href}>
          <Icon inline {icon} />
          {name}
        </a>
      </li>
    {/each}
    <small style="white-space: nowrap;">(emphasis &asymp; proficiency)</small>
  </ul>

  <h3>
    <Icon inline icon="material-symbols:interests" />&nbsp; Hobbies
  </h3>
  <ul>
    {#each cv.hobbies as { name, icon, href }}
      <li>
        <a {href}>
          <Icon inline {icon} />
          {name}
        </a>
      </li>
    {/each}
  </ul>

  <h3>
    <Icon inline icon="mdi:account-group" />
    &nbsp; Memberships
  </h3>
  <ul>
    {#each cv.memberships as { name, date, href }}
      <li>
        <a {href}>{name}</a>&ensp;<small>{date}</small>
      </li>
    {/each}
  </ul>
</aside>

<style>
  h4 a {
    display: flex;
    place-items: center;
  }
  h4 img {
    width: 3ex;
    height: 3ex;
    margin-right: 5pt;
  }
  section.title {
    grid-column: 1 / -1;
  }
  h1 {
    margin: 0 0 3pt;
  }
  h1 + small {
    text-align: center;
    display: block;
  }
  a {
    color: inherit;
  }
  address {
    display: flex;
    place-content: center;
    gap: 12pt;
    font-style: normal;
    font-weight: 200;
    margin: 1ex;
  }
  address a {
    display: flex;
    gap: 4pt;
    place-items: center;
  }
  h2::after {
    content: '';
    display: block;
    height: 0.5px;
    background-color: #bbb;
  }
  ul {
    list-style: none;
    padding: 0 0 0 4pt;
    margin: 0;
    place-items: center;
  }
  ul > li > h4 {
    margin: 9pt 0 4pt;
    display: flex;
    gap: 8pt;
    place-items: center;
  }
  p {
    margin: 0;
    font-size: 10pt;
    font-weight: 300;
  }
  img[alt$='Logo'] {
    height: 3ex;
    width: 3ex;
  }
  ul.skills {
    display: flex;
    gap: 4pt 8pt;
    flex-wrap: wrap;
  }
  aside {
    font-size: smaller;
  }
  aside > h3 {
    white-space: nowrap;
    margin: 3ex 0 1em;
  }
</style>

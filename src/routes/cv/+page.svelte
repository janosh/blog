<script lang="ts">
  import oss from '$lib/oss.yml'
  import papers from '$lib/papers.yaml'
  import Icon from '@iconify/svelte'
  import Papers from './Papers.svelte'
  import cv from './cv.yml'

  export let data

  const links = { target: `_blank`, rel: `noreferrer` }

  const social: [string, string][] = [
    [`mailto:${data.email}`, `mdi:email`],
    [`https://github.com/janosh`, `octicon:mark-github`],
    [`https://twitter.com/jrib_`, `fa-brands:twitter`],
    [`https://stackoverflow.com/u/4034025`, `mdi:stackoverflow`],
    [`https://linkedin.com/in/janosh-riebesell`, `bi:linkedin`],
  ]
</script>

<section class="title">
  <h1>Janosh Riebesell</h1>

  <small>
    <a href="https://materialsproject.org/about/people">
      Materials Project Staff @ Lawrence Berkeley National Lab
    </a>
  </small>

  <address>
    {#each social as [url, icon]}
      <a href={url} {...links}><Icon inline {icon} /></a>
    {/each}
  </address>
</section>

<section class="body">
  <small>
    I joined the Materials Project in early 2023 where I trained ML foundation models
    (CHGNet, MACE-MP) and build high-throughput workflows for generating large DFT
    datasets to train still bigger models on. I am a core maintainer of
    <a href="https://github.com/materialsproject/pymatgen">pymatgen</a>. I'm a big fan of
    high-quality open source software that enables new capabilities for scaling
    computational materials science.
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
  <Papers {...papers} />

  <h2>
    <Icon inline icon="ri:open-source-line" />&nbsp; Open Source
  </h2>
  <ul>
    {#each oss.projects as { url, img_style, repo, name, description, stars, logo, languages, commits }}
      {@const logo_url = logo ?? `${url}/favicon.svg`}
      <li>
        <h4>
          <a href={url ?? repo} {...links}>
            <img src={logo_url} alt="{name} Logo" style={img_style} />
            {name}
          </a>
          <a href={repo} {...links}>
            <Icon inline icon="octicon:mark-github" />
          </a>
          {#if stars}
            <a href="{repo}/stargazers">
              <small>{stars} ⭐</small>
            </a>
          {/if}
          {#if commits}
            <a href="{repo}/graphs/contributors">
              <Icon inline icon="octicon:git-commit" />
              <small>
                {commits}
                <span style="font-weight: 200;">commits</span>
              </small>
            </a>
          {/if}
          <small class="langs">{languages.slice(0, 3).join(`, `)}</small>
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
    <Icon inline icon="gis:search-country" />&nbsp; Nationality
    <ul>
      {#each cv.nationality as nat}
        <li>{nat}</li>
      {/each}
    </ul>
  </h3>

  <h3 style="margin-bottom: 0;">
    <Icon inline icon="carbon:skill-level-advanced" />&nbsp; Skills
  </h3>
  <small style="white-space: nowrap;">(emphasis &asymp; proficiency)</small>
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
  </ul>

  <h3>
    <Icon inline icon="material-symbols:interests" />&nbsp; Hobbies
  </h3>
  <ul>
    {#each cv.hobbies as { name, icon, href }}
      <li>
        {#if href}
          <a {href}>
            <Icon inline {icon} />
            {name}
          </a>
        {:else}
          <Icon inline {icon} />
          {name}
        {/if}
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
    container-type: inline-size;
  }
  ul > li > h4 {
    margin: 8pt 0 4pt;
    display: flex;
    gap: 8pt;
    place-items: center;
    font-size: smaller;
  }
  ul > li > h4 > small.langs {
    margin-left: 2ex;
    font-weight: 200;
    font-size: 9pt;
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
    max-height: max-content;
  }
  aside > h3 {
    white-space: nowrap;
    margin: 3ex 0 1em;
  }
</style>

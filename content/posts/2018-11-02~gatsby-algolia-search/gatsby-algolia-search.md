---
title: Custom search with Algolia in Gatsby
slug: /gatsby-algolia-search
date: 2018-11-02
cover:
  img: gatsby-algolia-search.svg
  source: Vecteezy
  url: https://vecteezy.com/vector-art/229827-web-search
tags:
  - Web Dev
  - Tutorial
  - JS
---

This post is a guide on how to write a React component that implements custom search powered by [Algolia](https://algolia.com) on a [Gatsby](https://gatsbyjs.org) site. You can see the result in action by clicking on the search icon in the top right of this page. The complete code is on [GitHub](https://github.com/janosh/blog/tree/master/src/components/Search). Also, check out Algolia's own CodeSandbox on how to use their [React Instantsearch](https://codesandbox.io/s/github/algolia/create-instantsearch-app/tree/templates/react-instantsearch) library.

If you're looking to add search to a documentation site with highly structured content, then you can let Algolia handle the steps outlined in the backend section for you by using their excellent [Docsearch](https://community.algolia.com/docsearch). For other types of sites and more fine-grained control over exactly what data should be indexed, read on.

## Backend

First, you'll need to add [`gatsby-plugin-algolia`](https://github.com/algolia/gatsby-plugin-algolia) and [`react-instantsearch-dom`](https://github.com/algolia/react-instantsearch) to your project. `react-instantsearch` is Algolia's library containing off-the-shelf React components which we can import to save ourselves a lot of work. If you're not using it already, also install [`dotenv`](https://github.com/motdotla/dotenv) while you're at it. We're going to need it to specify your Algolia app ID and both the search and admin API keys without committing them to version control.

```sh
yarn add gatsby-plugin-algolia react-instantsearch-dom dotenv
```

If you're project doesn't use them already, you will also need to install `react` and `styled-components`. The latter is optional but you will then have to convert some styled components to whichever design approach you use.

```sh
yarn add react styled-components
```

Next, add `gatsby-plugin-algolia` to your `gatsby-config.js`.

```js:title=gatsby-config.js
const queries = require('./src/utils/algolia')

require('dotenv').config()

module.exports = {
  siteMetadata: {
    title: `Gatsby+Algolia`,
    description: `How to setup Algolia search in Gatsby`,
    author: `Janosh Riebesell`,
  },
  plugins: [
    {
      resolve: `gatsby-plugin-algolia`,
      options: {
        appId: process.env.GATSBY_ALGOLIA_APP_ID,
        apiKey: process.env.ALGOLIA_ADMIN_KEY,
        queries,
        chunkSize: 10000, // default: 1000
      },
    },
  ],
}
```

Notice that we're loading `queries` from a file at `./src/utils/algolia.js` (you can of course put it wherever you like) and our Algolia ID and API key from `.env` so let's add those files.

```sh:title=.env
GATSBY_ALGOLIA_APP_ID = KA4OJA9KAS
GATSBY_ALGOLIA_SEARCH_KEY=lkjas987ef923ohli9asj213k12n59ad
ALGOLIA_ADMIN_KEY = lksa09sadkj1230asd09dfvj12309ajl
```

These are random character sequences but yours should be the same length. Also, it's good practice to commit a `.env.example` to version control so that if someone forks your repo, they know which environment variables they need to supply.

```sh:title=.env.example
# rename this file to .env and supply the values listed below
# also make sure they are available to the build tool (e.g. netlify)
# warning: variables prefixed with GATSBY_ will be made available to client-side code
# be careful not to expose sensitive data (in this case your Algolia admin key)

GATSBY_ALGOLIA_APP_ID=insertValue
GATSBY_ALGOLIA_SEARCH_KEY=insertValue
ALGOLIA_ADMIN_KEY=insertValue
```

The `queries` allow you to grab the data you want Algolia to index directly from Gatsby's GraphQL layer by exporting from `src/utils/algolia.js` an array of objects, each containing a required GraphQL query and an optional index name, transformer function and settings object.

```js:title=src/utils/algolia.js
const queryTemplate = (filters = ``, fields = ``) => `{
  allMdx(filter: {${filters}}) {
    nodes {
      objectID: id
      frontmatter {
        title
        slug
        ${fields}
      }
      excerpt(pruneLength: 5000)
    }
  }
}`

const flatten = arr =>
  arr.map(({ frontmatter, ...rest }) => ({ ...frontmatter, ...rest }))

const settings = { attributesToSnippet: [`excerpt:20`] }

const queries = [
  {
    query: queryTemplate(`frontmatter: {purpose: {eq: "page"}}`),
    transformer: res => flatten(res.data.allMdx.nodes),
    indexName: `Pages`,
    settings,
  },
  {
    query: queryTemplate(
      `fileAbsolutePath: {regex: "/posts/"}`,
      `tags date(formatString: "MMM D, YYYY")`
    ),
    transformer: res => flatten(res.data.allMdx.nodes),
    indexName: `Posts`,
    settings,
  },
]

module.exports = queries
```

It might look a little intimidating at first, but basically you're just letting `gatsby-plugin-algolia` know how to acquire the data with which to populate your indices on their servers. The example above uses separate queries passing data to separate indices for pages and blog posts.

Transformers allow you to modify the data returned by the queries to bring it into a format ready for searching. All we're doing here is 'flattening' posts and pages to 'unnest' the frontmatter fields (such as `author`, `date`, `tags`) but transformers could do much more for you if required. This makes the whole process of indexing your data really flexible and powerful. You could for instance use them to filter the results of your queries, format fields, add or merge them, etc.

If you've come this far, then the "backend" is done. You should now be able to run `gatsby build` and see your indices in Algolia's web interface be flooded with your data.

## Frontend

What remains is a user-facing search interface for your site. It needs a way for the user to enter a search string, send that string to Algolia, receive matching results (_hits_ in Algolia speak) from your indices and finally display those to the user. Let's dive right in.

We're going to assemble everything we need into a React `Search` component that we call from anywhere on our site where we want the user to be able to search. Even though design varies strongly from site to site, I'll also go through the styles implemented with [`styled-components`](https://styled-components.com) in this guide since working out the CSS transitions to have the search field slide out as the user clicks on it and the results pane to appear once Algolia returns matches took some time.

The `Search` components is made up of the following files:

- [**`index.js`**: the main component](https://github.com/janosh/blog/tree/master/src/components/Search/index.js)
- [**`input.js`**: the text input field](https://github.com/janosh/blog/tree/master/src/components/Search/Input.js)
- [**`hitComps.js`**: the components that will render matching posts/pages](https://github.com/janosh/blog/tree/master/src/components/Search/hitComps.js)
- [**`styles.js`**: the styled components](https://github.com/janosh/blog/tree/master/src/components/Search/styles.js)

There's quite a lot happening in these files so let's break them down one by one and piece by piece.

### `index.js`

```js:title=src/components/search/index.js
import React, { useState, useEffect, useMemo, createRef } from 'react'
import { connectStateResults, Index, InstantSearch } from 'react-instantsearch-dom'
import algoliasearch from 'algoliasearch/lite'

import { HitsWrapper, PoweredBy, Root } from './styles'
import Hits from './Hits'
import Input from './Input'

const Results = connectStateResults(
  ({ searching, searchState: state, searchResults: res }) => (
    <div>
      {(searching && `Searching...`) ||
        (res?.nbHits === 0 && `No results for '${state.query}'`)}
    </div>
  )
)

const Stats = connectStateResults(
  ({ searchResults: res }) =>
    res?.nbHits > 0 && `${res.nbHits} result${res.nbHits > 1 ? `s` : ``}`
)

const useOnClickOutside = (ref, handler, events) => {
  if (!events) events = [`mousedown`, `touchstart`]
  const detectClickOutside = event =>
    !ref.current.contains(event.target) && handler()
  useEffect(() => {
    for (const event of events) document.addEventListener(event, detectClickOutside)
    return () => {
      for (const event of events)
        document.removeEventListener(event, detectClickOutside)
    }
  })
}

export default function Search({ indices, collapse = true, hitsAsGrid }) {
  const ref = createRef()
  const [query, setQuery] = useState(``)
  const [focus, setFocus] = useState(false)
  // useMemo prevents the searchClient from being recreated on every render.
  // Avoids unnecessary XHR requests (see https://tinyurl.com/yyj93r2s).
  const searchClient = useMemo(
    () =>
      algoliasearch(
        process.env.GATSBY_ALGOLIA_APP_ID,
        process.env.GATSBY_ALGOLIA_SEARCH_KEY
      ),
    []
  )
  useOnClickOutside(ref, () => setFocus(false))
  return (
    <Root ref={ref}>
      <InstantSearch
        searchClient={searchClient}
        indexName={indices[0].name}
        onSearchStateChange={({ query }) => setQuery(query)}
      >
        <Input onFocus={() => setFocus(true)} {...{ collapse, focus }} />
        <HitsWrapper show={query.length > 0 && focus} asGrid={hitsAsGrid}>
          {indices.map(({ name, title, type }) => (
            <Index key={name} indexName={name}>
              <header>
                <h3>{title}</h3>
                <Stats />
              </header>
              <Results />
              <HitComp type={type} onClick={() => setFocus(false)} />
            </Index>
          ))}
          <PoweredBy />
        </HitsWrapper>
      </InstantSearch>
    </Root>
  )
}
```

At the top, we import `InstantSearch` from [`react-instantsearch-dom`](https://community.algolia.com/react-instantsearch) which is the root component that allows your whole search experience to connect to Algolia's service. As the name suggests, `Index` allows you to tap into an individual index and `Hits` provides you with the data returned for a user's search input. Finally [`connectStateResults`](https://community.algolia.com/react-instantsearch/connectors/connectStateResults.html) wraps around custom React components and provides them with high-level stats about the current search state such as the query, the number of results and how long it took to fetch them.

We then import the styled components that make up the UI and the `Input` component into which the user enters the query.

```js
import { Root, SearchBox, HitsWrapper, PoweredBy } from './styles'
import Input from './Input'
```

`PoweredBy` renders the string "Powered by Algolia" with a small logo and link. If you're using Algolia's generous free tier, they ask you to acknowledge them in this way below the search results. `react-instantsearch-dom` also provides a [`PoweredBy` component](https://community.algolia.com/react-instantsearch/widgets/PoweredBy.html) specifically for this purpose but I preferred to build my own. We'll get back to these styled components once we're done with `index.js`. For now, let's move on.

The last thing we need for the `Search` component to work is a hit component for every type of result we want to display to the user. It determines how attributes of matching results (such as author, date, tags and title in the case of a blog post) are displayed to the user.

```js
import Hits from './Hits'
```

Next we define two connected components. `Results` informs the user that no matches could be found for a query unless the number of hits is positive, i.e. `searchResults.nbHits > 0`. `Stats` just displays `searchResults.nbHits`.

```js
const Results = connectStateResults(
  ({ searching, searchState: state, searchResults: res }) =>
    (searching && <div>Searching...</div>) ||
    (res?.nbHits === 0 && <div>No results for &apos;{state.query}&apos;</div>)
)

const Stats = connectStateResults(
  ({ searchResults: res }) =>
    res?.nbHits > 0 && `${res.nbHits} result${res.nbHits > 1 ? `s` : ``}`
)
```

Now comes the actual `Search` component. It starts off with some state initialization, defining handler functions and event listeners to trigger them. All they do is make the search input slide out when the user clicks a search icon and disappear again when the user clicks or touches (on mobile) anywhere.

```js
const useOnClickOutside = (ref, handler, events) => {
  if (!events) events = [`mousedown`, `touchstart`]
  const detectClickOutside = event =>
    !ref.current.contains(event.target) && handler()
  useEffect(() => {
    for (const event of events) document.addEventListener(event, detectClickOutside)
    return () => {
      for (const event of events)
        document.removeEventListener(event, detectClickOutside)
    }
  })
}

export default function Search({ indices, collapse = true, hitsAsGrid }) {
  const ref = createRef()
  const [query, setQuery] = useState(``)
  const [focus, setFocus] = useState(false)
  // useMemo prevents the searchClient from being recreated on every render.
  // Avoids unnecessary XHR requests (see https://tinyurl.com/yyj93r2s).
  const searchClient = useMemo(
    () =>
      algoliasearch(
        process.env.GATSBY_ALGOLIA_APP_ID,
        process.env.GATSBY_ALGOLIA_SEARCH_KEY
      ),
    []
  )
  useOnClickOutside(ref, () => setFocus(false))
  return // ...
}
```

`Search` returns JSX that renders a dynamic array of `indices` passed as a prop. Each array item should be an object with keys `name`, `title`, `hitComp` that specifies the name of the index in your Algolia account to be queried, the title to display above the results shown to the user and the component `hitComp` that renders the data returned for each match.

```js
return (
  <Root ref={ref}>
    <InstantSearch
      searchClient={searchClient}
      indexName={indices[0].name}
      onSearchStateChange={({ query }) => setQuery(query)}
    >
      <Input onFocus={() => setFocus(true)} {...{ collapse, focus }} />
      <HitsWrapper show={query.length > 0 && focus} asGrid={hitsAsGrid}>
        {indices.map(({ name, title, type }) => (
          <Index key={name} indexName={name}>
            <header>
              <h3>{title}</h3>
              <Stats />
            </header>
            <Results />
            <Hits type={type} onClick={() => setFocus(false)} />
          </Index>
        ))}
        <PoweredBy />
      </HitsWrapper>
    </InstantSearch>
  </Root>
)
```

Passing this `indices` array as a prop allows you to reuse the same `Search` component in different parts of your site and have each of them query different indices. As an example, besides a primary search box in the header used for finding pages and/or posts, your site might have a wiki and you want to offer your visitors a second search box that displays only wiki articles.

Note that we fed `algoliasearch` with the same app ID we specified in our `.env` file and used in `src/utils/algolia.js` as well as with our search-only API key to generate a search client which connects to our backend. _Don't paste in your Algolia admin API key here!_ `algoliasearch` only needs to _read_ your indices. Pasting your admin key here would allow others to obtain it once your site is deployed. They could then start messing with your indexed data on Algolia.

## `input.js`

```js
import React from 'react'
import { connectSearchBox } from 'react-instantsearch-dom'

import { SearchIcon, Form, Input } from './styles'

export default connectSearchBox(({ refine, ...rest }) => (
  <Form>
    <Input
      type="text"
      placeholder="Search"
      aria-label="Search"
      onChange={e => refine(e.target.value)}
      // iOS Safari doesn't blur input automatically on tap outside.
      onMouseLeave={e => e.target.blur()}
      {...rest}
    />
    <SearchIcon />
  </Form>
))
```

The `Input` component is where the user enters the search string. It is quite short since the grunt work is done by Algolia's [`connectSearchBox`](https://community.algolia.com/react-instantsearch/connectors/connectSearchBox.html) function.

Now let's look at the styled components `SearchIcon`, `Form`, `Input` as well as the ones imported in `index.js`.

## `styled.js`

```js:title=src/components/Search/styles.js
import React from 'react'
import styled, { css } from 'styled-components'
import { Algolia } from 'styled-icons/fa-brands'
import { Search } from 'styled-icons/fa-solid'

export const Root = styled.div`
  position: relative;
  display: grid;
  grid-gap: 1em;
  color: var(--color-text);
`

export const SearchIcon = styled(Search)`
  width: 1em;
  pointer-events: none;
  color: white;
`

const focus = css`
  background: white;
  color: var(--color-blue-dark);
  cursor: text;
  width: 5em;
  + ${SearchIcon} {
    color: var(--color-blue-dark);
    margin: 0 0.3em;
  }
`

const collapsed = css`
  width: 0;
  cursor: pointer;
  color: var(--color-blue-lighter);
  ${props => props.focus && focus}
  margin-left: ${props => (props.focus ? `-1.6em` : `-1em`)};
  padding-left: ${props => (props.focus ? `1.6em` : `1em`)};
  ::placeholder {
    color: var(--color-gray-default);
  }
`

const expanded = css`
  background: white;
  width: 6em;
  margin-left: -1.6em;
  padding-left: 1.6em;
  + ${SearchIcon} {
    margin: 0.3em;
  }
`

export const Input = styled.input`
  outline: none;
  border: none;
  font-size: 1em;
  background: transparent;
  transition: 0.3s;
  border-radius: 0.2em;
  ${props => (props.collapse ? collapsed : expanded)};
`

export const Form = styled.form`
  display: flex;
  flex-direction: row-reverse;
  align-items: center;
`

export const HitsWrapper = styled.div`
  display: ${props => (props.show ? `grid` : `none`)};
  background: var(--color-background);
  max-height: 80vh;
  overflow: scroll;
  z-index: 2;
  position: absolute;
  right: 0;
  top: calc(100% + 0.5em);
  width: 80vw;
  max-width: 30em;
  box-shadow: 0 0 5px 0 black;
  padding: 0.7em 1em 0.4em;
  border-radius: 0.2em;
  * {
    margin-top: 0;
  }
  > div {
    padding-top: 0.6em;
  }
  div + div {
    margin-top: 0.6em;
    border-top: 1px solid var(--color-gray-lighter);
  }
  mark {
    color: var(--color-blue-lighter);
    background: var(--color-blue-dark);
  }
  header {
    display: flex;
    justify-content: space-between;
    border-bottom: 2px solid var(--color-gray-dark);
    h3 {
      color: white;
      background: var(--color-gray-default);
      padding: 0.1em 0.4em;
      border-radius: 0.2em;
      margin-bottom: 0.3em;
    }
  }
  * + header {
    padding-top: 1em;
  }
  h4 {
    margin-bottom: 0.3em;
  }
`

export const PoweredBy = () => (
  <span css="font-size: 0.6em; text-align: end; padding: 0;">
    Powered by{` `}
    <a href="https://algolia.com">
      <Algolia size="1em" /> Algolia
    </a>
  </span>
)
```

Styles will of course be different from one site to the next so I only list these components here for completeness and because they implement the dynamic behavior of the search interface, i.e. that the input field only slides out once the user clicks the `SearchIcon` (a magnifier) and that the pane displaying search (`HitsWrapper`) results only appears once Algolia's server returned matches, both of you which you might want to keep.

Now we're almost done. 2 small steps remain. First, we need to put together a hit component for every type of result we want to display. In our example, these are blog posts and pages. And second, we need to call our `Search` component somewhere on our site. Here are the hit components.

## `Hits.js`

```js:title=src/components/Search/Hits.js
import { Link } from 'gatsby'
import React, { Fragment } from 'react'
import { Highlight, Snippet } from 'react-instantsearch-dom'
import { Tags } from 'styled-icons/fa-solid'
import { Calendar } from 'styled-icons/octicons'
import { connectHits } from 'react-instantsearch-dom'

const postHit = hit => (
  <div>
    <Calendar size="1em" />
    &nbsp;
    <Highlight attribute="date" hit={hit} tagName="mark" />
    &emsp;
    <Tags size="1em" />
    &nbsp;
    {hit.tags.map((tag, index) => (
      <Fragment key={tag}>
        {index > 0 && `, `}
        {tag}
      </Fragment>
    ))}
  </div>
)

export default connectHits(function HitComp({ type, hits, onClick }) {
  const extend = { postHit }[type]
  return hits.map(hit => (
    <div key={hit.objectID}>
      <Link to={hit.slug} onClick={onClick}>
        <h4>
          <Highlight attribute="title" hit={hit} tagName="mark" />
        </h4>
      </Link>
      {extend && extend(hit)}
      <Snippet attribute="excerpt" hit={hit} tagName="mark" />
    </div>
  ))
})
```

`Highlight` and `Snippet` imported from `react-instantsearch-dom` both display attributes of matching search results to the user. Their distinction is that the former renders it in full (e.g. a title, date or list of tags) whereas the latter only shows a snippet, i.e. a text passage of given length surrounding the matching string (e.g. for body texts). In each case the `attribute` prop should be the name of the property as it was assigned in `src/utils/algolia.js` and as it appears in your Algolia indices.

## Usage

Now all we need to do is import `Search` somewhere. The obvious place is the `Header` component so let's add it there.

```js:title=src/components/Header/index.js
import React from 'react'

import { Container, Logo } from './styles'
import Nav from '../Nav'
import Search from '../Search'

const searchIndices = [
  { name: `Pages`, title: `Pages` },
  { name: `Posts`, title: `Blog Posts`, type: `postHit` },
]

const Header = ({ site }) => (
  <Container>
    <Logo to="/" title={site.title} rel="home" />
    <Nav />
    <Search collapse indices={searchIndices} />
  </Container>
)

export default Header
```

Note that this is where we define our array of search indices and pass it as a prop to `Search`. If everything works as expected, running `gatsby develop` should now give you some instant search magic in your site's header! How cool is that! :sunglasses:

---
title: Custom Algolia search with Gatsby
slug: gatsby-algolia-search
date: 2018-11-02
cover: ./images/gatsby+algolia.png
tags:
  - Web Development
  - Tutorial
---

In this post I'll explain how to setup [Algolia search](https://www.algolia.com) on a [Gatsby](https://gatsbyjs.org) site. You can see the result in action by clicking on the loupe in the top right corner of this page.

First, you'll need to add [`gatsby-plugin-algolia`](https://github.com/algolia/gatsby-plugin-algolia) and [`react-instantsearch-dom`](https://github.com/algolia/react-instantsearch) to your project. With `react-instantsearch` Algolia provides an extensive library of off-the-shelf React components that we can simply import to save ourselves a lot of work. If you're not using it already, also install [`dotenv`](https://github.com/motdotla/dotenv) while you're at it. We're going to need it to specify your Algolia app ID and API key without commiting it to version control.

```bash
yarn add gatsby-plugin-algolia react-instantsearch-dom dotenv
```

Next, add `gatsby-plugin-algolia` to your `gatsby-config.js`.

```javascript
// gatsby-config.js
const queries = require('./src/utils/algolia')

require('dotenv').config()

module.exports = {
  siteMetadata: {
    title: `Gatsby+Algolia`,
    description: `How to setup Algolia search in Gatsby`,
    author: `Janosh Riebesell`,
    siteUrl: `https://janosh.io`,
  },
  plugins: [
    {
      resolve: `gatsby-plugin-algolia`,
      options: {
        appId: process.env.algoliaAppId,
        apiKey: process.env.algoliaApiKey,
        queries,
        chunkSize: 10000, // default: 1000
      },
    },
  ],
}
```

Notice that we're loading `queries` from a file at `./src/utils/algolia.js` (you can of course put it wherever you like) and our Algolia ID and key from `.env` so let's add those files.

```javascript
// .env
algoliaAppId = KA4OJA9KAS
algoliaApiKey = lksa09sadkj1230asd09dfvj12309ajl
```

I inserted random character sequences here but yours should be the same length. Also, it's good practice to commit a `.env.example` to version control so that if someone forks your repo, they know immediately which environment variables they need to supply.

```javascript
// .env.example
algoliaAppId = insertValue
algoliaApiKey = insertValue
```

And here are the `queries`.

```javascript
// src/utils/algolia.js
const pageQuery = `{
  pages: allMarkdownRemark(
    filter: {
      fileAbsolutePath: { regex: "/pages/" },
      frontmatter: {purpose: {eq: "page"}}
    }
  ) {
    edges {
      node {
        objectID: id
        frontmatter {
          title
          slug
        }
        excerpt(pruneLength: 5000)
      }
    }
  }
}`

const postQuery = `{
  posts: allMarkdownRemark(
    filter: { fileAbsolutePath: { regex: "/posts/" } }
  ) {
    edges {
      node {
        objectID: id
        frontmatter {
          title
          slug
          date(formatString: "MMM DD, YYYY")
          tags
        }
        excerpt(pruneLength: 5000)
      }
    }
  }
}`

const flatten = arr =>
  arr.map(({ node: { frontmatter, ...rest } }) => ({
    ...frontmatter,
    ...rest,
  }))
const settings = { attributesToSnippet: [`excerpt:20`] }

const queries = [
  {
    query: pageQuery,
    transformer: ({ data }) => flatten(data.pages.edges),
    indexName: `Pages`,
    settings,
  },
  {
    query: postQuery,
    transformer: ({ data }) => flatten(data.posts.edges),
    indexName: `Posts`,
    settings,
  },
]

module.exports = queries
```

It might look a little initmidating at first, but really these are just GraphQl queries that `gatsby-plugin-algolia` runs to get the data with which to populate your indices on Algolia's servers. I'm using separate one's for my posts and pages to keep things organized but you could have all your data in one index.

Notice also that you can run transformers on the data returned by the queries to bring it into a format ready for searching. All I'm doing here is 'flattening' my posts and pages to 'unnest' the frontmatter but this is really flexible and powerful and you could do a lot more with these transformers if necessary.

If you've come this far, then the backend so to speak is done. You can now run `gatsby build` and if it runs without errors you should see your indices in Algolia's webinterface flooded with all your data.

All that remains to be done now is to add the front-facing search interface to your website. It needs to grab the indexed data from Algolia and display it to the user. To be honest, this is the part that took me much longer to get looking and working the way wanted but it should be much quicker with a little guidance. So let's get to it.

We're going to assemble everything we need into a React `Search` component that we call from anywhere on our site where we want the user to be able to search.

The first step is to create the main component file.

```javascript
// src/components/Search/index.js
import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import {
  InstantSearch,
  Index,
  Hits,
  connectStateResults,
} from 'react-instantsearch-dom'
import { Algolia } from 'styled-icons/fa-brands/Algolia'

import { Root, SearchBox, HitsWrapper, By } from './styles'
import * as hitComps from './hits'

const events = ['mousedown', 'touchstart']

const Results = connectStateResults(
  ({ searchState: state, searchResults: res, children }) =>
    res && res.nbHits ? children : `No results for ${state.query}`
)

const Stats = connectStateResults(
  ({ searchResults: res }) =>
    res && res.nbHits > 0 && `${res.nbHits} result${res.nbHits > 1 ? `s` : ``}`
)

export default class Search extends Component {
  state = { query: ``, showHits: false }

  updateState = state => this.setState(state)

  enableHits = () => {
    this.setState({ showHits: true })
  }

  disableHits = () => {
    this.setState({ showHits: false })
  }

  handleClickOutside = event => {
    const node = ReactDOM.findDOMNode(this.node)
    if (node && !node.contains(event.target)) {
      this.setState({ showHits: false })
    }
  }

  componentDidMount() {
    events.forEach(event =>
      document.addEventListener(event, this.handleClickOutside)
    )
  }

  componentWillUnmount() {
    events.forEach(event =>
      document.removeEventListener(event, this.handleClickOutside)
    )
  }

  render() {
    const { query, showHits } = this.state
    const { indices, collapse, hitsAsGrid } = this.props
    return (
      <InstantSearch
        appId="KA4OJA9KAS"
        apiKey="ljhba0981kbed0adskj1230asdj123lj"
        indexName={indices[0].name}
        onSearchStateChange={this.updateState}
        root={{ Root }}
        ref={node => (this.node = node)}
      >
        <SearchBox collapse={collapse} onFocus={this.enableHits} />
        <HitsWrapper
          show={query.length > 0 && showHits}
          hitsAsGrid={hitsAsGrid}
        >
          {indices.map(({ name, title, hitComp }) => (
            <Index key={name} indexName={name}>
              <header>
                {title && <h2>{title}</h2>}
                <Stats />
              </header>
              <Results>
                <Hits hitComponent={hitComps[hitComp](this.disableHits)} />
              </Results>
            </Index>
          ))}
          <By>
            Powered by{' '}
            <a href="https://www.algolia.com">
              <Algolia size="1em" /> Algolia
            </a>
          </By>
        </HitsWrapper>
      </InstantSearch>
    )
  }
}
```

There's quite a lot happening in this file so let's break it down piece by piece.

```javascript
import {
  InstantSearch,
  Index,
  Hits,
  connectStateResults,
} from 'react-instantsearch-dom'
```

`InstantSearch` imported from `react-instantsearch-dom` is Algolia's main off-the-shelf React component that allows your whole search experience to connect to their service. As the name suggests, `Index` allows you to connect to an individual index and `Hits` provides you with the data returned for a user's search input. Finally `connectStateResults` gives some high-level stats about the current search state such as the query, the number of results and how long it took to fetch them.

```javascript
import { Algolia } from 'styled-icons/fa-brands/Algolia'
```

Since I'm using Algolia's generous free tier, I import Algolia's logo from `styled-icons` to show a little `Powered by Algolia` acknowledgement with their icon below the search results.

```javascript
import { Root, SearchBox, HitsWrapper, By } from './styles'
```

I used [`styled-components`](https://www.styled-components.com) to design all aspects of `Search` and the components are imported next. I'll get back to them once we're done with this file.

```javascript
const Results = connectStateResults(
  ({ searchState: state, searchResults: res, children }) =>
    res && res.nbHits ? children : `No results for ${state.query}`
)

const Stats = connectStateResults(
  ({ searchResults: res }) =>
    res && res.nbHits > 0 && `${res.nbHits} result${res.nbHits > 1 ? `s` : ``}`
)
```

Next we define two small connected components. `Results` informs the user that no matches could be found for a query if `searchResults.nbHits == 0`. `Stats` just displays `searchResults.nbHits`.

Now comes the actual `Search` components class. It starts off with a bunch of setup, i.e. initialize state, define handler functions and make those trigger with event listeners. These are all just to make the search input slide out when the user clicks a loupe and make it disappear again when the user clicks anywhere else or starts to scroll.

```javascript
const { indices, collapse, hitsAsGrid } = this.props
...
{indices.map(({ name, title, hitComp }) => (
<Index key={name} indexName={name}>
    <header>
    {title && <h2>{title}</h2>}
    <Stats />
    </header>
    <Results>
    <Hits hitComponent={hitComps[hitComp](this.disableHits)} />
    </Results>
</Index>
))}
```

Finally, the `render` function takes a dynamic array of `indices` passed as a prop. This allows you to have search boxes in different places of your site query different Algolia indices. For instance, your site might have a wiki and you want to offer your visitors a search that only displays results for that.

```javascript
<InstantSearch
  appId="ZOE4SGQ9EG"
  apiKey="14dedbd0f24d124cf32c1c9f9ff3df61"
  indexName={indices[0].name}
  onSearchStateChange={this.updateState}
  root={{ Root }}
  ref={node => (this.node = node)}
>
```

Note that we feed `InstantSearch` with the same app ID we specified in our `.env` file and with our search-only API key. Don't paste in your admin API key here! `InstantSearch` only needs to _read_ your indices. Pasting your admin key here would allow others to obtain it and start messing with your indexed data on Algolia.

Now we come to the styled components. Of course, design is something that will be very different from one site to the next so I only list them here for completeness and because it might save some time to simply copy and customize them.

```javascript
import styled, { css } from 'styled-components'
import { Search } from 'styled-icons/fa-solid/Search'
import Input from './SearchBox'

export const Root = styled.div`
  position: relative;
  display: grid;
  grid-gap: 1em;
`

export const Loupe = styled(Search)`
  width: 1em;
  margin: 0.3em;
  pointer-events: none;
`

const collapse = css`
  width: 0;
  cursor: pointer;
  color: ${props => props.theme.lightBlue};
  + ${Loupe} {
    color: ${props => props.theme.mainWhite};
  }
  :focus {
    background: ${props => props.theme.mainWhite};
    color: ${props => props.theme.mainGray};
    cursor: text;
    width: 5em;
    + ${Loupe} {
      color: ${props => props.theme.mainGray};
    }
  }
  ::placeholder {
    color: ${props => props.theme.mainGray};
  }
`

const expand = css`
  background: ${props => props.theme.lightGray};
  width: 6em;
`

export const SearchBox = styled(Input)`
  display: flex;
  flex-direction: row-reverse;
  align-items: center;
  input {
    outline: none;
    border: none;
    font-size: 1em;
    background: transparent;
    transition: ${props => props.theme.shortTrans};
    margin-left: -1.6em;
    padding-left: 1.6em;
    border-radius: ${props => props.theme.smallBorderRadius};
    ${props => (props.collapse ? collapse : expand)};
  }
`

const list = css`
  position: absolute;
  right: 0;
  top: calc(100% + 0.5em);
  width: calc(4em + 40vw);
  max-width: 30em;
  box-shadow: 0 0 5px 0;
  padding: 0.7em 1em 0.4em;
  background: ${props => props.theme.mainWhite};
  border-radius: ${props => props.theme.smallBorderRadius};
  > * + * {
    padding-top: 1em !important;
    border-top: 2px solid ${props => props.theme.darkGray};
  }
  li + li {
    margin-top: 0.7em;
    padding-top: 0.7em;
    border-top: 1px solid ${props => props.theme.lightGray};
  }
`

const grid = css`
  ul {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(15em, 1fr));
    grid-gap: 1em;
    li {
      padding: 0.3em 0.5em;
      background: ${props => props.theme.veryLightGray};
      border-radius: ${props => props.theme.smallBorderRadius};
    }
  }
`

export const HitsWrapper = styled.div`
  display: ${props => (props.show ? `grid` : `none`)};
  max-height: 80vh;
  overflow: scroll;
  ${props => (props.hitsAsGrid ? grid : list)};
  * {
    margin-top: 0;
    padding: 0;
  }
  ul {
    list-style: none;
  }
  mark {
    color: ${props => props.theme.mainWhite};
    background: ${props => props.theme.darkBlue};
  }
  header {
    display: flex;
    justify-content: space-between;
  }
  h2 {
    margin: 0 0 0.5em;
  }
  h3 {
    margin-bottom: 0.3em;
  }
`

export const By = styled.span`
  font-size: 0.6em;
  text-align: end;
  padding: 0;
`
```

Now we're almost done. 3 small steps remain. First, we need to put together a hit component for every type of result we want to display. In my case, these are blog posts and pages. Second, we need to define the actual input field into which the user can type queries. And third, we need to call our `Search` component on at least one of our pages.

So first up, here are the post and page hit components

```javascript
// src/components/Search/PageHit.js
import React from 'react'
import { Highlight, Snippet } from 'react-instantsearch-dom'
import { Link } from 'gatsby'

const PageHit = clickHandler => ({ hit }) => (
  <div>
    <Link to={hit.slug} onClick={clickHandler}>
      <h3>
        <Highlight attribute="title" hit={hit} tagName="mark" />
      </h3>
    </Link>
    <Snippet attribute="excerpt" hit={hit} tagName="mark" />
  </div>
)

export default PageHit
```

```javascript
// src/components/Search/PostHit.js
import React from 'react'
import { Highlight, Snippet } from 'react-instantsearch-dom'
import { Link } from 'gatsby'

const PageHit = clickHandler => ({ hit }) => (
import React, { Fragment } from 'react'
import { Highlight, Snippet } from 'react-instantsearch-dom'
import { Link } from 'gatsby'
import { Calendar } from 'styled-icons/octicons/Calendar'
import { Tags } from 'styled-icons/fa-solid/Tags'

const PostHit = clickHandler => ({ hit }) => (
  <div>
    <Link to={`/blog/` + hit.slug} onClick={clickHandler}>
      <h3>
        <Highlight attribute="title" hit={hit} tagName="mark" />
      </h3>
    </Link>
    <div>
      <Calendar size="1em" />
      &nbsp;
      <Highlight attribute="date" hit={hit} tagName="mark" />
      &emsp;
      <Tags size="1em" />
      &nbsp;
      {hit.tags.map((tag, index) => (
        <Fragment key={tag}>
          {!!index && ', '}
          <Link to={`blog/` + tag.toLowerCase().replace(` `, `-`)}>{tag}</Link>
        </Fragment>
      ))}
    </div>
    <Snippet attribute="excerpt" hit={hit} tagName="mark" />
  </div>
)

export default PostHit
```

For the search box a simple input suffices.

```javascript
// src/components/Search/SearchBox.js
import React from 'react'
import { connectSearchBox } from 'react-instantsearch-dom'

import { Loupe } from './styles'

export default connectSearchBox(({ refine, onFocus, className }) => (
  <form className={className}>
    <input
      type="text"
      placeholder="Search"
      aria-label="Search"
      onChange={e => refine(e.target.value)}
      onFocus={onFocus}
    />
    <Loupe />
  </form>
))
```

And that's everything! Now all we need to do is import `Search` somewhere. The obvious place is the `Header` component so let's add it there.

```javascript
// src/components/Header/index.js
import React from 'react'

import { Container, Logo } from './styles'
import Nav from '../Nav'
import Search from '../Search'

const searchIndices = [
  { name: `Pages`, title: `Pages`, hitComp: `PageHit` },
  { name: `Posts`, title: `Blog Posts`, hitComp: `PostHit` },
]

const Header = ({ site, transparent }) => (
  <Container transparent={transparent}>
    <Logo to="/" title={site.title} rel="home" />
    <Nav />
    <Search collapse indices={searchIndices} />
  </Container>
)

export default Header
```

Note that this is where define our array of search indices and pass it as a prop to `Search`. If everything works as expected, running `gatsby develop` should now give you some instant search magic in your site's header! How cool is that? :sunglasses:

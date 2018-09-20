import algoliasearch from 'algoliasearch/lite'
import { useOnClickOutside } from 'hooks'
import React, { createRef, useMemo, useState } from 'react'
import { connectStateResults, Index, InstantSearch } from 'react-instantsearch-dom'
import Hits from './Hits'
import Input from './Input'
import { HitsWrapper, PoweredBy, Root } from './styles'

const Results = connectStateResults(
  ({ searching, searchState, searchResults: res }) =>
    (searching && <div>Searching...</div>) ||
    (res?.nbHits === 0 && <div>No results for &apos;{searchState.query}&apos;</div>)
)

const Stats = connectStateResults(
  ({ searchResults: res }) =>
    res?.nbHits > 0 && `${res.nbHits} result${res.nbHits > 1 ? `s` : ``}`
)

const appId = process.env.GATSBY_ALGOLIA_APP_ID
const searchKey = process.env.GATSBY_ALGOLIA_SEARCH_KEY

export default function Search({ indices, collapse = true, size, ...rest }) {
  const ref = createRef()
  const [query, setQuery] = useState(``)
  const [focus, setFocus] = useState(false)
  // useMemo prevents the searchClient from being recreated on every render.
  // Avoids unnecessary XHR requests (see https://tinyurl.com/yyj93r2s).
  const searchClient = useMemo(() => algoliasearch(appId, searchKey), [])
  useOnClickOutside(ref, () => setFocus(false))
  return (
    <Root ref={ref} {...rest}>
      <InstantSearch
        searchClient={searchClient}
        indexName={indices[0].name}
        onSearchStateChange={({ query }) => setQuery(query)}
      >
        <Input onFocus={() => setFocus(true)} {...{ size, collapse, focus }} />
        <HitsWrapper show={query.length > 0 && focus}>
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
}

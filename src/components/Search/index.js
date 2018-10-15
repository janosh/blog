import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import algoliasearch from 'algoliasearch/lite'
import {
  InstantSearch,
  SearchBox,
  Index,
  Hits,
  Stats,
  connectStateResults,
} from 'react-instantsearch-dom'
import { Algolia } from 'styled-icons/fa-brands/Algolia'

import { Root, HitsWrapper, Input, Loupe, By } from './styles'
import PageHit from './PageHit'
import PostHit from './PostHit'

const searchClient = algoliasearch(
  'ZOE4SGQ9EG',
  '14dedbd0f24d124cf32c1c9f9ff3df61'
)

const events = ['mousedown', 'touchstart']

const Results = connectStateResults(
  ({ searchState: state, searchResults: results, children }) =>
    results && results.nbHits ? children : `No results for ${state.query}`
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
    return (
      <InstantSearch
        indexName="Pages"
        searchClient={searchClient}
        onSearchStateChange={this.updateState}
        root={{ Root }}
        ref={node => (this.node = node)}
      >
        <Input>
          <SearchBox
            translations={{ placeholder: `Search` }}
            onFocus={this.enableHits}
          />
          <Loupe />
        </Input>
        <HitsWrapper show={this.state.query.length > 0 && this.state.showHits}>
          <Stats
            translations={{
              stats: n => `${n} Result${n > 1 ? `s` : ``}`,
            }}
          />
          <Index indexName="Pages">
            <h2>Pages</h2>
            <Results>
              <Hits hitComponent={PageHit(this.disableHits)} />
            </Results>
          </Index>
          <Index indexName="Posts">
            <h2>Posts</h2>
            <Results>
              <Hits hitComponent={PostHit(this.disableHits)} />
            </Results>
          </Index>
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

---
title: useQueryParam
slug: /use-query-param
date: 2019-06-15
cover:
  img: urlQueryParam.svg
  source: Vecteezy
  url: https://vecteezy.com/vector-art/165556-domain-illustration-free-vector
tags:
  - JS
  - Tutorial
  - Web Dev
---

Here's a straightforward implementation of a React hook that allows you to set, modify and remove URL query parameters. There is already a popular and high-quality implementation by [Peter Beshai on GitHub](https://github.com/pbeshai/use-query-params). I was going to use that at first but about two-thirds of the way through reading its source code I decided that it's a little overengineered for my simple use case. Peter's `use-query-params` offers React Router and Reach Router integrations, uses `React.createContext` internally to pass their history objects down to subscribing components, has dependencies on external packages and requires you to import and then specify types (numbers, strings, arrays, etc.) for any query parameter you specify. All I want to do is append the odd string to a URL. I'm happy to rely on simple browser APIs to do it for me. (Should I need to store more sophisticated data types than strings to a URL search string in the future, I guess I'll just try my luck with `JSON.stringify` and `JSON.parse`.)

So I decided to start from scratch and roll my own hook. Considering that it ended up taking only around 30 lines of code, I think it was the right decision for my use case. Here's the code:

```js:title=src/hooks/useQueryParam.js
import { useState } from 'react'

const handleParam = (key, value, options = {}) => {
  // Required for SSR. Do nothing if location object is not available.
  if (typeof location !== `undefined`) {
    // historyMethod: push or replace (https://developer.mozilla.org/docs/Web/API/History)
    // to either add to the browser history or replace the last item
    const { historyMethod = `replace`, nullDeletes = true } = options

    // Parse current query string using the browser's URLSearchParams API.
    const params = new URLSearchParams(location.search)

    // If the passed value is undefined, check if the URL already contains
    // a value for it. This is important on initial page load.
    if (value === undefined) value = params.get(key)
    // If the passed value is null and the nullDeletes option is
    // set to true, delete the corresponding query parameter.
    else if (value === null && nullDeletes) params.delete(key)
    // Else use the provided key and value to set a new query parameter.
    else params.set(key, value)

    // Construct URL containing the updated query parameter(s).
    let target = location.pathname + `?` + params.toString()
    target = target.replace(/\/?\?$/, ``) // remove ? if search string is empty

    history[historyMethod + `State`]({ path: value }, ``, target) // update the browser URL

    return value
  }
}

export const useQueryParam = (key, value, options) => {
  // Relies on useState to trigger component rerenders on calls to setParam.
  const [param, setParam] = useState(handleParam(key, value, options))

  // override allows changing options for individual setQueryParam calls
  const setter = (newValue, override) =>
    setParam(handleParam(key, newValue, { ...options, ...override }))

  return [param, setter]
}
```

`key` and `value` will appear as `?(...&)key=value` in the URL query. The `options` object can contain a boolean `nullDeletes` which specifies on a per-hook basis whether passing `null` as the value should delete the parameter from the URL query, as well as a string `historyMethod` that determines whether changes to the query should replace or be appended to the browser history. With the default `historyMethod = 'replace'`, the user will get back to the previous page immediately when using the browser's back button. `historyMethod = 'push'`, will require one back button press for every time `setQueryParam` is called on that page.

## Usage Example

Here's an example of how to use this hook to filter a list of posts on a blog page by tag.

```js:title=src/pages/blog.js
import React from 'react'
import { PostList, TagList } from 'components'
import { useQueryParam } from 'hooks' // highlight-line

const filterPostsByTag = (tag, posts) =>
  posts.filter(post => post.tags.includes(tag))

export default function BlogPage({ posts, tags }) {
  const [activeTag, setActiveTag] = useQueryParam(`tag`) // highlight-line
  const filteredPosts = filterPostsByTag(activeTag, posts)
  return (
    <>
      <TagList {...{ tags, activeTag, setActiveTag }} />
      <PostList posts={filteredPosts} />
    </>
  )
}
```

The `TagList` component in the last highlighted line simply uses `setActiveTag` in an `onClick` callback function `onClick={() => setActiveTag(tag.title)}`. Note that an `All` tag would set the active tag to `null` so that clicking it will remove the `tag` query parameter from the address bar completely.

```js:title=src/components/TagList.js
import React from 'react'
import { Tag, TagGrid, Toggle } from './styles'

export const TagList = ({ tags, activeTag = `All`, setActiveTag }) => (
  <TagGrid>
    <h2>Tags</h2>
    {tags.map(({ title, count }) => (
        <Tag
          key={title}
          active={activeTag === title || (title === `All` && !activeTag)} // highlight-line
          onClick={() => setActiveTag(title === `All` ? null : title)} // highlight-line
        >
          {title} ({count})
        </Tag>
      )
    })
  </TagGrid>
)
```

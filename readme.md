# [janosh.io](https://janosh.io)

This repo powers the [Gatsby](https://gatsbyjs.org) site hosted at [janosh.io](https://janosh.io). I use it to write about personal interests. Mostly theoretical physics, machine learning, sustainability and web development.

The site is fully responsive, has [fluid typography](https://css-tricks.com/snippets/css/fluid-typography) and relies heavily on [React Hooks](https://reactjs.org/docs/hooks-intro) for stateful components and CSS grid for layout. It uses following libraries:

- [**styled-components**](https://styled-components.com) for design
- [**KaTeX**](https://katex.org) for typesetting math
- [**Prism**](https://prismjs.com) for syntax highlighting
- [**Disqus**](https://disqus.com) for blog post comments
- [**Algolia**](https://www.algolia.com) for custom search
- [**react-spring**](https://www.react-spring.io) for animations

Feel free to reuse any part of this repo to create your own Gatsby site.

## Installation

Assuming you have `git`, `node`, `gatsby-cli` and `yarn` (or `npm`) installed, to get this site running locally follow these steps:

1. Clone the repo to your machine and change into its directory.

    ```sh
    git clone https://github.com/janosh/janosh.io && cd janosh.io
    ```

2. Install dependencies with

    ```sh
    yarn
    ```

3. Start the dev server.

    ```sh
    gatsby develop
    ```

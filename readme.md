# [janosh.io](https://janosh.io)

This repo powers the [Gatsby](https://gatsbyjs.org) site [janosh.io](https://janosh.io). I use it to write about personal interests. Mostly theoretical physics, machine learning, sustainability and web development.

The site is fully responsive, has [fluid typography](https://css-tricks.com/snippets/css/fluid-typography), relies heavily on [React Hooks](https://reactjs.org/docs/hooks-intro) for stateful components and CSS grid for layout. It uses the following libraries:

- [**styled-components**](https://styled-components.com) for design
- [**KaTeX**](https://katex.org) for typesetting math
- [**Prism**](https://prismjs.com) for syntax highlighting
- [**Disqus**](https://disqus.com) for blog post comments
- [**Algolia**](https://www.algolia.com) for custom search
- [**react-spring**](https://www.react-spring.io) for animations

Feel free to reuse the whole or any part of this repo to create your own Gatsby site.

## Installation

To get this site running locally, you need installed [`git`](https://git-scm.com), [`gatsby-cli`](https://www.gatsbyjs.org/packages/gatsby-cli) and [`yarn`](https://yarnpkg.com) (or [`npm`](https://www.npmjs.com)). Then follow these steps:

1. Clone the repo to your machine and change into its directory.

    ```sh
    git clone https://github.com/janosh/janosh.io && cd janosh.io
    ```

2. Install dependencies.

    ```sh
    yarn
    ```

3. Start the dev server.

    ```sh
    gatsby develop
    ```

## Deployment

The easiest way to get this site published is as follows:

1. Create an account with [netlify](https://www.netlify.com).
2. Install the [`netlify-cli`](https://www.netlify.com/docs/cli).
3. Login to your account.

    ```sh
    netlify login
    ```

4. Connect your GitHub repo with your netlify account for [continuous deployment](https://www.netlify.com/docs/cli/#continuous-deployment).

    ```sh
    netlify init
    ```

5. Finally deploy the site with

    ```sh
    netlify deploy
    ```
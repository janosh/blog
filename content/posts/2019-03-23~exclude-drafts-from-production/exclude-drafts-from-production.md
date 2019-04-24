---
title: Exclude drafts from production in Gatsby
slug: /exclude-drafts-from-production
date: 2019-03-19
cover:
  img: exclude-drafts-from-production.svg
tags:
  - WebDev
  - Tutorial
  - JS
---

Kyle Mathews who created Gatsby [started a dicussion](https://github.com/gatsbyjs/gatsby/issues/25) about how to exclude files during the build process for the production version of a site. You might want to do this if you have some blog posts lying around that are in a draft state and not ready for primetime yet. The question was asked way back in Sep 2015 but hasn't resulted in a canonical solution, unfortunately.

[Alexander Bradley](https://github.com/gatsbyjs/gatsby/issues/25#issuecomment-364717023) and [David Poindexter](https://github.com/gatsbyjs/gatsby/issues/25#issuecomment-379488775) both proposed solutions that filter out posts with a frontmatter property `published` (or don't have a property `draft` if you prefer) in `gatsby-node.js`. In my opinion, this comes with some downsides.

When filtering out draft content for the production build, it's best to do so as close to the source as possible. There might be multiple places where draft content shows up on your site and if you don't do the filtering until you've reached `gatsby-node`'s page creation, you would have to implement the filtering in all of these places places individually. For blog posts that might be your blog's index page and/or landing page that displays a list of most recent posts. This leads to verbosity and, if you forget a place, might leak your draft content.

If the content is part of the site's repo, a solution that avoids these problems is to use `gatsby-source-filesystem`'s ignore option. You could add a prefix such as draft- to all files containing draft content and combine that with

```js:title=gatsby-config.js
{
  resolve: `gatsby-source-filesystem`,
  options: {
    path: `${__dirname}/content`,
    ignore: process.env.NODE_ENV === `production` && [`**/draft-*`]
  }
}
```

Then, once the content is ready to be published, simply remove the file's `draft-` prefix and build.

An advantage to this approach is that it works with both files and folders. If you want to exclude multiple files, simply add the prefix to the parent directory. For instance, you could have a permanent `drafts` folder and move posts in and out of this folder as needed. In that case, you'd replace ``[`**/draft-*`]`` with ``[`**/posts/drafts`]``

You can then also prevent those files from cluttering up your `git` tracker by adding this directory to your `.gitignore`.

```text:title=.gitignore
# draft posts
posts/drafts
```

## Other options?

Another cool solution would have been to completely delete the nodes corresponding to draft content right when Gatsby creates. However, [`actions.deleteNode`](https://www.gatsbyjs.org/docs/actions/#deleteNode) [doesn't seem to be supported](https://github.com/gatsbyjs/gatsby/issues/10844#issuecomment-471375400) inside [`exports.onCreateNode`](https://www.gatsbyjs.org/docs/node-apis/#onCreateNode).

```js:title=gatsby-node.js
exports.onCreateNode = ({ node, actions }) => {
  if (
    process.env.NODE_ENV === `production` &&
    node.frontmatter &&
    node.frontmatter.draft
  )
    actions.deleteNode({ node })
}
```

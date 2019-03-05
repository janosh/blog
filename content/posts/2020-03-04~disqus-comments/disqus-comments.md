---
title: Gatsby Blog with Disqus comments
slug: /disqus-comments
date: 2019-03-03
cover:
  img: gatsby+disqus.svg
tags:
  - Web Development
  - Tutorial
---

If you're running a Gatsby blog (or any React-powered blog for that matter) and you'd like to add comment functionality, rest assured, it's very easy. I just went through that process and the only thing that took time was deciding which service to use. There are quite a few to choose from. The ones I considered were all mentioned in a [2017 Gatsby Spectrum chat](https://spectrum.chat/gatsby-js/general/whats-the-best-way-to-make-commenting-system~0c7e3f0f-8737-4948-9c52-0d20dfe37a05?m=MTUxNjM2MjE1NTY1MA==):

- [Disqus](https://disqus.com) [[mention](https://spectrum.chat/gatsby-js/general/whats-the-best-way-to-make-commenting-system~0c7e3f0f-8737-4948-9c52-0d20dfe37a05?m=MTUxMTIzMDE0NjY2MQ==)]
- [Staticman](https://staticman.net) [[mention](https://spectrum.chat/gatsby-js/general/whats-the-best-way-to-make-commenting-system~0c7e3f0f-8737-4948-9c52-0d20dfe37a05?m=MTUzNDkxODUxMDk4OA==)]
- [Facebook comments](https://www.npmjs.com/package/react-facebook) [[mention](https://spectrum.chat/gatsby-js/general/whats-the-best-way-to-make-commenting-system~0c7e3f0f-8737-4948-9c52-0d20dfe37a05?m=MTU0MTEwNTQyNDI1MA==)]
- [JustComments](https://just-comments.com) [[mention](https://spectrum.chat/gatsby-js/general/whats-the-best-way-to-make-commenting-system~0c7e3f0f-8737-4948-9c52-0d20dfe37a05?m=MTU0MTQ0MzcxMTgxMQ==)]
- [TalkYard](https://www.talkyard.io) [[mention](https://spectrum.chat/gatsby-js/general/whats-the-best-way-to-make-commenting-system~0c7e3f0f-8737-4948-9c52-0d20dfe37a05?m=MTUxNjMzMzM5MTU5NA==)]

I ended up going with Disqus because it

- seems to be the most widely used option,
- is low maintenance,
- [has great React support](https://github.com/disqus/disqus-react),
- [offers a generous free tier](https://disqus.com/pricing).

The other services seemed excellent as well, though, and are well worth checking out. Staticman, for instance, took an interesting approach. Essentially, you set up your own HTML form for writing comments, let it send a POST request on submission to one of their endpoints. From this Staticman will automatically submit a pull request to your site's repo which you can accept or deny. If that isn't a geeky way of doing comment moderation, I don't know what is. This has the big advantage of keeping everything static (hence the name). All your data is in one place (your repo) as opposed to having to be loaded through JavaScript embeds or iframes on the fly. It will remain there even if Staticman is ever discontinued. With the other services, you depend on an external platform to deliver your comments.

Of course, in return you have the disadvantage of having more manual setup with putting together the comment form and hooking it up to Staticman. Of course, depending on your use case, this degree of customizability might actually be an advantage. In any case, I wanted something with as little manual configuration and setup as possible. Disqus turned out to perfect in this regard.

Here are the steps to bring Disqus comments to your own blog:

1. [Sign-up to Disqus](https://disqus.com/profile/signup). During the process you'll have to choose shortname for your site. This is how Disqus will identify comments coming from your site. Copy that for later.
2. Install the Disqus React package

   ```sh
   yarn add disqus-react
   ```

3. Add the shortname from step 1 as something like `GATSBY_DISQUS_NAME` to your `.env` and `.env.example` files so that people forking your repo will know that they need to supply this value to get comments to work. (You need to prefix the environment variable with `GATSBY_` in order to [make it available to client side code](https://www.gatsbyjs.org/docs/environment-variables/#client-side-javascript).)
   ```env
   // .env.example
   ...
   # enables Disqus comments below blog posts
   GATSBY_DISQUS_NAME=insertValue
   ```
   ```env
   // .env
   ...
   GATSBY_DISQUS_NAME=yourOwnSiteShortname
   ```
4. Go to your template file for blog post (in my case `src/templates/post.js`) and import the `DiscussionEmbed` React component.

   ```js{3}
   import React from 'react'
   import { graphql } from 'gatsby'
   import { DiscussionEmbed } from 'disqus-react'
   ...
   ```

   Then define your Disqus configuration object

   ```js
   const disqusConfig = {
     shortname: process.env.GATSBY_DISQUS_NAME,
     config: { identifier: slug, title },
   }
   ```

   where `identifier` must be a string or number that uniquely identifies the post. Finally, add `DiscussionEmbed` to the JSX of your post template.

   ```jsx{6}
   return (
     <Global>
       ...
       <PageBody>
         ...
         <DiscussionEmbed {...disqusConfig} />
       </PageBody>
     </Global>
   )
   ```

And you're done. You should now see the Disqus comment form appear beneath your blog post just like the one below this post. Happy blogging! :sunglasses:

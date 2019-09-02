import { graphql } from 'gatsby'

export const query = graphql`
  fragment post on Mdx {
    frontmatter {
      title
      subtitle
      slug
      date(formatString: "MMM D, YYYY")
      tags
      showToc
      ...cover
    }
    timeToRead
    excerpt(pruneLength: 200)
    body
  }
`

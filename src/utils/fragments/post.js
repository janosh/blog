import { graphql } from "gatsby"

export const query = graphql`
  fragment post on MarkdownRemark {
    frontmatter {
      title
      slug
      date(formatString: "MMM DD, YYYY")
      tags
      ...cover
    }
    timeToRead
    excerpt(pruneLength: 200)
    html
  }
`

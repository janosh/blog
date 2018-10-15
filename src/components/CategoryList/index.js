import React, { Fragment } from 'react'
import PropTypes from 'prop-types'

import { List, CategoryLink } from './styles'

const Category = ({ category }) => {
  const { title, totalCount } = category
  const link = `/blog/` + title.toLowerCase().replace(` `, `-`)
  return (
    <CategoryLink activeClassName="active" to={link}>
      {title} ({totalCount})
    </CategoryLink>
  )
}

const CategoryList = ({ title, categories }) => (
  <Fragment>
    <h1>{title}</h1>
    <List>
      <CategoryLink activeClassName="active" to="/blog">
        All
      </CategoryLink>
      {categories.map(category => (
        <Category key={category.title} category={category} />
      ))}
    </List>
  </Fragment>
)

export default CategoryList

CategoryList.propTypes = {
  title: PropTypes.string,
  categories: PropTypes.arrayOf(
    PropTypes.shape({
      title: PropTypes.string.isRequired,
      totalCount: PropTypes.number.isRequired,
    })
  ),
}

CategoryList.defaultProps = {
  title: `Categories`,
}

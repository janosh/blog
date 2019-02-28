import React, { useState, Fragment } from "react"

import Grid from "../../components/styles/Grid"
import Modal from "../../components/Modal"

import { Thumbnail, LargeImg, Caption } from "./styles"

const Photos = ({ photos }) => {
  const [modal, setModal] = useState()
  return (
    <Grid minWidth="10em" height="10em">
      {photos.map(({ node }, index) => (
        <Fragment key={node.title}>
          <div onClick={() => setModal(index)}>
            <Thumbnail alt={node.title} fluid={node.img.sharp.fluid} />
          </div>
          <Modal
            open={index === modal}
            modal={modal}
            setModal={setModal}
            navigation
            white
            css="padding: 0; max-width: 80vw;"
          >
            <LargeImg alt={node.title} fluid={node.img.sharp.fluid} />
            <Caption>{node.title}</Caption>
          </Modal>
        </Fragment>
      ))}
    </Grid>
  )
}

export default Photos

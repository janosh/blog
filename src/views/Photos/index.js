import React, { useState, Fragment } from "react"

import Grid from "../../components/styles/Grid"
import Modal from "../../components/Modal"

import { Thumbnail, LargeImg, modalCss } from "./styles"

const Photos = ({ photos }) => {
  const [modal, setModal] = useState()
  return (
    <Grid minWidth="10em">
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
            css={modalCss}
          >
            <LargeImg alt={node.title} fluid={node.img.sharp.fluid} />
          </Modal>
        </Fragment>
      ))}
    </Grid>
  )
}

export default Photos

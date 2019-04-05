import React, { useCallback } from "react"
import MarkerClusterer from "@google/markerclustererplus"

import Masonry from "../../components/Masonry"
import { Caption } from "../../components/styles"
import Modal from "../../components/Modal"
import Map from "../../components/Map"

import { Thumbnail, LargeImg } from "./styles"

const addMarkers = (photos, setModal) => map => {
  const markers = photos.map(({ caption, lat, lng }, index) => {
    const marker = new window.google.maps.Marker({
      map,
      position: { lat, lng },
      label: `${index + 1}`,
      title: caption,
    })
    marker.addListener(`click`, () => setModal(index))
    return marker
  })
  new MarkerClusterer(map, markers)
}

const mapProps = (...args) => ({
  options: {
    center: { lat: 40, lng: 10 },
    zoom: 3,
  },
  onMount: addMarkers(...args),
})

const Photos = ({ tab, photos, modal, setModal }) => {
  const MemoMap = useCallback(<Map {...mapProps(photos, setModal)} />, [])
  return (
    <>
      {tab === `list` ? (
        <Masonry>
          {photos.map((photo, index) => (
            <div onClick={() => setModal(index)} key={photo.caption}>
              <Thumbnail alt={photo.caption} fluid={photo.fluid} />
            </div>
          ))}
        </Masonry>
      ) : (
        MemoMap
      )}
      {modal >= 0 && modal < photos.length && (
        <Modal
          open={true}
          modal={modal}
          setModal={setModal}
          navigation
          white
          css="max-width: 80vw;"
        >
          <LargeImg alt={photos[modal].caption} fluid={photos[modal].fluid} />
          <Caption>
            <h3 css="margin: 0;">{photos[modal].caption}</h3>
          </Caption>
        </Modal>
      )}
    </>
  )
}

export default Photos

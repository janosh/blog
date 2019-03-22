import React, { useMemo } from "react"
import MarkerClusterer from "@google/markerclustererplus"

import Masonry from "../../components/Masonry"
import Caption from "../../components/styles/Caption"
import Modal from "../../components/Modal"
import Map from "../../components/Map"

import { Thumbnail, LargeImg } from "./styles"

const addMarkers = (photos, setModal) => map => {
  const markers = photos.map((photo, index) => {
    const marker = new window.google.maps.Marker({
      map,
      position: photo.gps,
      label: `${index + 1}`,
      title: photo.title,
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
  const MemoMap = useMemo(() => <Map {...mapProps(photos, setModal)} />, [])
  photos = photos.filter(photo => photo.iptc)
  return (
    <>
      {tab === `list` ? (
        <Masonry>
          {photos.map((photo, index) => (
            <div onClick={() => setModal(index)} key={photo.iptc.headline}>
              <Thumbnail alt={photo.iptc.headline} fluid={photo.fluid} />
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
          <LargeImg
            alt={photos[modal].iptc.headline}
            fluid={photos[modal].fluid}
          />
          <Caption>
            <h3 css="margin: 0;">{photos[modal].iptc.headline}</h3>
          </Caption>
        </Modal>
      )}
    </>
  )
}

export default Photos

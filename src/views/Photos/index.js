import MarkerClusterer from '@google/markerclustererplus'
import React from 'react'
import Map from '../../components/Map'
import Masonry from '../../components/Masonry'
import Modal from '../../components/Modal'
import { Caption } from '../../components/styles'
import { Img, Thumbnail } from './styles'

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

export default function Photos({ tab, photos, modal, setModal }) {
  const currentPhoto = modal >= 0 && modal < photos.length && photos[modal]
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
        <Map
          options={{ center: { lat: 40, lng: 10 }, zoom: 3 }}
          onMount={addMarkers(photos, setModal)}
        />
      )}
      <Modal
        open={currentPhoto}
        {...{ modal, setModal }}
        whiteControls
        fullScreenDefault
        css="background: black; display: grid; align-items: center;"
      >
        <Img
          alt={currentPhoto.caption}
          fluid={currentPhoto.fluid}
          imgStyle={{ objectFit: `contain` }}
          css="height: fill-available;"
        />
        <Caption>
          <h3 css="margin: 0;">{currentPhoto.caption}</h3>
        </Caption>
      </Modal>
    </>
  )
}

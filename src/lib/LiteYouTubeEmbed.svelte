<script lang="ts">
  // adapted from https://github.com/zamanruhy/svelte-lite-youtube-embed
  interface Props {
    video_id: string
    play_label?: string
  }

  let { video_id, play_label = `Play` }: Props = $props()

  let activated = $state(false)
  const activate = () => (activated = true)

  $effect(() => {
    if (video_id) activated = false // reset on new video_id
  })
</script>

<div
  class="lite-youtube"
  class:activated
  onclick={activate}
  onkeyup={activate}
  role="presentation"
>
  {#key video_id}
    <picture>
      <source
        srcset="https://i.ytimg.com/vi_webp/{video_id}/hqdefault.webp"
        type="image/webp"
      />
      <img
        class="poster"
        src="https://i.ytimg.com/vi/{video_id}/hqdefault.jpg"
        alt={play_label}
      />
    </picture>
  {/key}
  <button type="button" class="play-btn" aria-label={play_label}></button>
  {#if activated}
    <iframe
      width="560"
      height="315"
      title={play_label}
      allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
      allowfullscreen
      src="https://www.youtube-nocookie.com/embed/{encodeURIComponent(
        video_id,
      )}?autoplay=1"
    ></iframe>
  {/if}
</div>

<style>
  .lite-youtube {
    background-color: #000000;
    position: relative;
    display: block;
    contain: content;
    cursor: pointer;
    max-width: 720px;
  }
  /* responsive iframe with a 16:9 aspect ratio, from https://css-tricks.com/responsive-iframes/ */
  .lite-youtube::after {
    content: '';
    display: block;
    padding-bottom: calc(100% / (16 / 9));
  }
  .lite-youtube > iframe {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    border: 0;
  }
  .poster {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    object-fit: cover;
  }
  .lite-youtube > .play-btn {
    width: 68px;
    height: 48px;
    position: absolute;
    cursor: pointer;
    transform: translate3d(-50%, -50%, 0);
    top: 50%;
    left: 50%;
    z-index: 1;
    background-color: transparent;
    /* YouTube's actual play button svg */
    background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 68 48"><path fill="%23f00" fill-opacity="0.8" d="M66.52,7.74c-0.78-2.93-2.49-5.41-5.42-6.19C55.79,.13,34,0,34,0S12.21,.13,6.9,1.55 C3.97,2.33,2.27,4.81,1.48,7.74C0.06,13.05,0,24,0,24s0.06,10.95,1.48,16.26c0.78,2.93,2.49,5.41,5.42,6.19 C12.21,47.87,34,48,34,48s21.79-0.13,27.1-1.55c2.93-0.78,4.64-3.26,5.42-6.19C67.94,34.95,68,24,68,24S67.94,13.05,66.52,7.74z"></path><path d="M 45,24 27,14 27,34" fill="%23fff"></path></svg>');
    filter: grayscale(100%);
    transition: filter 0.1s cubic-bezier(0, 0, 0.2, 1);
    border: none;
    outline: 0;
  }
  .lite-youtube:hover > .play-btn, .lite-youtube .play-btn:focus {
    filter: none;
  }
  /* Post-click styles */
  .lite-youtube.activated {
    cursor: unset;
  }
  .lite-youtube.activated::before, .lite-youtube.activated > .play-btn {
    opacity: 0;
    pointer-events: none;
  }
</style>

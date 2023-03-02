---
title: Geometric Bayes Theorem
date: 2020-10-04
cover:
  img: geometric-bayes-banner.svg
tags:
  - interactive
  - Bayes theorem
  - educational
  - probability
  - statistics
---

<script>
  import GeometricBayes from './GeometricBayes.svelte'
  import YouTubeEmbed from '$lib/LiteYouTubeEmbed.svelte'
  import { page } from '$app/stores'

  const file = encodeURIComponent(`src/routes/${$page.route.id}/+page.md`)
</script>

[3blue1brown-inspired](https://youtu.be/HZGCoVF3YvM) interactive visualization of Bayes theorem interpreted geometrically.

<GeometricBayes />

<legend>

## Legend

- p(H) = probability of hypothesis
- p(E|H) = probability of evidence given hypothesis
- p(E|&not;H) = probability of evidence given the hypothesis is false
- p(H|E) = probability of hypothesis given evidence (what we ultimately want to know)

</legend>

### Play around with the code

[![Open in StackBlitz](https://developer.stackblitz.com/img/open_in_stackblitz_small.svg)](https://stackblitz.com/github/janosh/blog?file={file})

## Bayes Theorem by Grant Sanderson (3Blue1Brown)

<YouTubeEmbed video_id="HZGCoVF3YvM" />

<style>
  legend {
    margin: 5em auto 2em;
  }
</style>

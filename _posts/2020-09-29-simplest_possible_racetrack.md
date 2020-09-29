---
layout: post
title: "Simplest Possible Racetrack"
date: 2020-09-29 10:00:00 -0500
---

Where do we start when developing a piece of software? At the beginning.

In the case of [Mikey's Racing Game](/racing-game/), we can start with the
simplest possible racetrack. I can't think of a simpler race than "start
here, go that way, first person to the finish line wins". A straight line.

But since we are racing cars we can't just use a line. We'll need a road or
something at least as wide as our car. So we'll start with a rectangle. It
will contain a start and finish line. And that's it. Here's a quick mock-up
I did in [GIMP](https://www.gimp.org/):

![Simple Race Track](/img/blog/simple-race-track.png)

Start in the green area on the left, race along the grey colored track
until you reach the checkerboard finish line area.

So... how should we model this thing in memory? We're trying to keep things
simple for now, so maybe we should overlay a grid on this track. If we
make each cell in the grid equal to a 10m square, then our car can fit
inside the cell, 
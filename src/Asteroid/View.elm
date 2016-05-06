module Asteroid.View (..) where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import List exposing (map)

line =
    { color = rgb 255 14 93
    , width = 1
    , cap = Flat
    , join = Smooth
    , dashing = []
    , dashOffset = 0
    }

asteroid a =
    ngon 6 a.radius
        |> filled (rgba 255 14 93 0.5)
        |> move (a.x, a.y)
        |> rotate (degrees a.angle)

root asteroids (w, h) =
    asteroids
        |> List.map asteroid


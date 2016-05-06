module Asteroid.View (..) where

import Html exposing (..)
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
    ngon 8 15 |> outlined line |> move (a.x, a.y)

root asteroids (w, h) =
    asteroids
        |> List.map asteroid


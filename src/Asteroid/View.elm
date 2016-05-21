module Asteroid.View exposing(..)

import Color exposing (..)
import Color.Convert exposing (hexToColor)
import Collage exposing (..)
import Element exposing (..)
import Text exposing (..)
import List exposing (map)

line =
    { color = rgb 255 14 93
    , width = 1
    , cap = Flat
    , join = Smooth
    , dashing = []
    , dashOffset = 0
    }

asteroidColour a =
    (Maybe.withDefault (rgba 255 14 93 0.5) (hexToColor a.colour))

asteroid a =
    let
        t = fromString ((toString a.aa) ++ "," ++ (toString a.ra))
            |> centered
            |> toForm
            |> move (a.x, a.y)
    in
    --group [ t ,
    ngon 6 a.radius
        |> filled (asteroidColour a)
        |> alpha 0.5
        |> move (a.x, a.y)
        |> rotate (degrees a.angle)
        --]

root asteroids (w, h) =
    asteroids
        |> List.map asteroid


module Asteroid.View exposing(..)

import Color exposing (..)
import Color.Convert exposing (hexToColor)
import Collage exposing (..)
import Element exposing (..)
import Text exposing (..)
import List exposing (map)
import Debug exposing (log)
import Config exposing (relativePosition)

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

asteroid dim a =
    let
    {--
        this is all diagnostic stuff but remember to comment it out because it *really*
        slows things down!
        (px, py) = (100 * (cos (degrees a.aa)), 100 * (sin (degrees a.aa)))
        l = traced { defaultLine | color = white } (path [(a.x,a.y), (a.x + px, a.y + py)])

        t = fromString (toString a.aa)
            |> centered
            |> toForm
            |> move (a.x, a.y)

        v = 
            (case a.v of
                Nothing -> fromString ""
                Just v ->
                    fromString ((toString v.x) ++ "," ++ (toString v.y)))
                        |> centered
                        |> toForm
                        |> move (a.x, a.y)

        (x, y) = translatePosition dim a
        pos =
            fromString ((toString x) ++ "," ++ (toString y))
                |> centered
                |> toForm
                |> move (x, y)
    --}
        (x, y) = relativePosition dim a
    in
    --group [ l , t,
    --group [ pos,
    ngon 6 a.radius
        |> filled (asteroidColour a)
        |> alpha 0.5
        --|> move (a.x, a.y)
        |> move (x, y)
    --]


root asteroids (w, h) =
    asteroids
        |> List.map (asteroid (w, h))


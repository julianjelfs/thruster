module Starfield.View exposing (..)

import Html exposing (..)
import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import List exposing (map)
import Random exposing (float, initialSeed, step)
import Time


randomFloat seed ( min, max ) =
    step (float min max) seed


createStars num stars seed width height =
    if (List.length stars == num) then
        stars
    else
        let
            ( w, s1 ) =
                randomFloat seed width

            ( h, s2 ) =
                randomFloat s1 height

            star =
                circle 2 |> filled white |> move ( w, h )
        in
            createStars num (star :: stars) s2 width height


minMax v =
    ( negate ((toFloat v) / 2), ((toFloat v) / 2) )


root maybeTime ( w, h ) =
    case maybeTime of
        Just t ->
            createStars
                50
                []
                (initialSeed (Time.inMilliseconds t |> round))
                (minMax w)
                (minMax h)

        Nothing ->
            []

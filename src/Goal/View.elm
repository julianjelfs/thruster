module Goal.View exposing (..)

import Color exposing (..)
import Element exposing (..)
import Collage exposing (..)
import Text exposing (..)


root score name colour pos =
    let
        txt =
            fromString (toString score)
                |> bold
                |> Text.height 40
                |> centered
                |> toForm
                |> alpha 0.6
                |> move pos
    in
        group
            [ txt
            , circle 150
                |> filled colour
                |> alpha 0.3
                |> move pos
            ]

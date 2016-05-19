module Hud.View exposing(..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import List exposing (map)
import Debug exposing (log)

root player (w, h) =
    let
        x = (toFloat w) / 2
                |> negate
        y = (toFloat h) / 2
                |> negate
        l = (toFloat h) / 2
        pos = (x + 50, y + (l / 2) + 50)

    in
    rect 50 l
        |> filled green
        |> alpha 0.5
        |> move pos

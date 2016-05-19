module Hud.View exposing(..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import List exposing (map)
import Debug exposing (log)

gaugePos (w, h) =
    let
        x = (toFloat w) / 2
                |> negate
        y = (toFloat h) / 2
                |> negate
        l = (toFloat h) / 2
    in
        (x + 50, y + (l / 2) + 50, l)

gaugeLevel player (l,h) =
    rect 50 l
        |> filled green
        |> alpha 0.6
        |> move (0,(negate h))

fullGauge l =
    rect 50 l
        |> filled red
        |> alpha 0.3

root player (w, h) =
    let
        (x,y,l) = gaugePos (w,h)
        fg = fullGauge l
        level = (player.power / 100 * l)
        diff = (l - level) / 2
        gl = gaugeLevel player (level, diff)
    in
        group [fg, gl]
            |> move (x,y)

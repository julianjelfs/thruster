module Player.View (..) where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import List exposing (map)

player p =
    ngon 3 40
        |> filled blue
        |> move (p.x, p.y)
        |> rotate (degrees p.angle)

root players (w, h) =
    players
        |> List.map player

module Player.View (..) where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import List exposing (map)
import Debug exposing (log)

grad =
    linear (0,0) (40,40) [(0, blue), (1, green)]

teamColour p =
    if p.team == "Green" then
        green
    else if p.team == "Blue" then
        blue
    else
        yellow

rocket =
    polygon ([ (-20,0)
            , (-8,5)
            , (-12,11)
            , (6,11)
            , (8,12)
            , (8,15)
            , (20,20)
            , (20,-20)
            , (8,-15)
            , (8,-12)
            , (6,-11)
            , (-12,-11)
            , (-8,-5)
            ] |> List.map (\(x,y) -> ((x-5)*2, y*2)))

player p =
    let
        tc = teamColour p
    in
        rocket
            |> filled tc
            |> move (p.x, p.y)
            |> rotate (degrees p.angle)

root players (w, h) =
    players
        |> List.map player

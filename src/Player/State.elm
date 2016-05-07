module Player.State (..) where

import Player.Types exposing (..)
import Agents exposing (Player)
import Effects exposing (Effects, Never)
import Debug exposing (log)

speed = 10

newPosition angle {y} =
    let
        h = (toFloat y) * speed
        dx = h * (cos angle)
        dy = h * (sin angle)
    in
        (dx, dy)


constrain: Float -> Int -> Float
constrain dim limit =
    let
        limitf = toFloat limit
        upper = limitf / 2
        lower = negate upper
    in
        if dim > upper then
            lower
        else if dim < lower then
            upper
        else
            dim

update : Action -> Player -> (Int, Int) -> ( Player, Effects Action )
update action player (w, h) =
    case action of
        Move wasd ->
            let
                angle = player.angle + (wasd.x * speed |> toFloat |> negate)
                (x, y) = (newPosition (degrees angle) wasd)
                px = constrain player.x w
                py = constrain player.y h
            in
                ( { player |
                    angle = angle
                    , x = px + x
                    , y = py + y
                    }, Effects.none )

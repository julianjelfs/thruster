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

update : Action -> Player -> (Int, Int) -> ( Player, Effects Action )
update action player (w, h) =
    case action of
        Move wasd ->
            let
                angle = player.angle + (wasd.x * speed |> toFloat |> negate)
                (x, y) = (newPosition (degrees angle) wasd)
                --if we go out of bounds we need to loop back through the other side
            in
                ( { player |
                    angle = angle
                    , x = player.x + x
                    , y = player.y + y
                    }, Effects.none )

module Player.State (..) where

import Player.Types exposing (..)
import Agents exposing (Player)
import Effects exposing (Effects, Never)
import Debug exposing (log)

newPosition angle {y} =
    let
        h = (toFloat y) * 5
        dx = h * cos (radians angle)
        dy = h * sin (radians angle)
    in
        (dx, dy)

update : Action -> Player -> ( Player, Effects Action )
update action player =
    case action of
        Move wasd ->
            let
                xy = (log "arrows: " wasd)
                angle = player.angle - (toFloat (wasd.x * 5))
                (x, y) = newPosition angle wasd
            in
                ( { player | angle = angle, x = player.x + x, y = player.y + y }, Effects.none )

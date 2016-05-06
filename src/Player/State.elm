module Player.State (..) where

import Player.Types exposing (..)
import Agents exposing (Player)
import Effects exposing (Effects, Never)
import Debug exposing (log)

update : Action -> Player -> ( Player, Effects Action )
update action player =
    case action of
        Rotate arrows ->
            let
                xy = (log "arrows: " arrows)
                dec = arrows.x * 5
            in
                ( { player | angle = player.angle - (toFloat dec) }, Effects.none )

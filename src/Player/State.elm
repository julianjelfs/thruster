module Player.State (..) where

import Player.Types exposing (..)
import Agents exposing (Player)
import Effects exposing (Effects, Never)
import Debug exposing (log)

update : Action -> Maybe Player -> ( Maybe Player, Effects Action )
update action player =
    case action of
        Rotate arrows ->
            let
                xy = (log "arrows: " arrows)
                -- send back an update to the server ?
                -- or should we just do that on an interval?
            in
                case player of
                    Just p ->
                        (player, Effects.none )
                    Nothing ->
                        (player, Effects.none )

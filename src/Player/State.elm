module Player.State exposing(..)

import Player.Types exposing (..)
import Agents exposing (Player)
import Debug exposing (log)

update : Msg -> Player -> ( Player, Cmd Msg )
update msg player =
    case msg of
        Tick _ ->
            (player, Cmd.none)
        KeyDown code ->
            let
                k = log "down: " code
            in
                (player, Cmd.none)
        KeyUp code ->
            let
                k = log "up: " code
            in
                (player, Cmd.none)


module State exposing(..)

import Types exposing (..)
import Join.State
import Player.State
import Agents exposing (Player, nullPlayer)
import Debug exposing (log)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayerMsg sub ->
            let
                me = model.me
                    |> Maybe.withDefault nullPlayer

                (updated, fx) =
                    Player.State.update sub me
            in
                ({ model | me = (Just updated) }, Cmd.none)

        JoinMsg sub ->
            let
                (updated, fx) =
                    Join.State.update (log "sub: " sub) model.join
            in
                ( { model | join = updated }, Cmd.map JoinMsg fx )

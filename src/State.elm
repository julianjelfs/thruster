module State exposing(..)

import Types exposing (..)
import Join.State
import Player.State
import Agents exposing (Player, nullPlayer)
import Debug exposing (log)
import Messages exposing (messageTypes, welcomeMessage, deltaMessage, updateMessage)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TaskDone () ->
            (model, Cmd.none)

        ScreenSizeChanged dim ->
            ( { model | screen = (log "screen size: " dim) }, Cmd.none)
        InboundMessage (time, msg) ->
            if msg.messageType == messageTypes.welcome then
                let
                    maybeWm = welcomeMessage msg
                in
                    case maybeWm of
                        Just wm ->
                            ( { model | joined = True
                                , joinedAt = Just time
                                , me = Just wm.me
                                , players = wm.players
                                , asteroids = wm.asteroids }, Cmd.none)
                        Nothing ->
                            ( model, Cmd.none )
            else if msg.messageType == messageTypes.delta then
                let
                    maybeDelta = deltaMessage msg
                in
                    case maybeDelta of
                        Just d ->
                            ( { model | players = d.players
                                , asteroids = d.asteroids }, Cmd.none)
                        Nothing ->
                            ( model, Cmd.none )
            else
                ( model, Cmd.none)

        PlayerMsg sub ->
            let
                me = model.me
                    |> Maybe.withDefault nullPlayer

                (updated, fx) =
                    Player.State.update sub me model.screen
            in
                ({ model | me = (Just updated) }, Cmd.none)
                {-- TODO just use a port directly for this
                ( { model | me = (Just updated) }, (Signal.send model.outSocket (updateMessage updated)
                    |> Effects.task
                    |> Effects.map TaskDone ))
                --}

        JoinMsg sub ->
            let
                (updated, fx) =
                    Join.State.update sub model.join
            in
                ( { model | join = updated }, Cmd.map JoinMsg fx )

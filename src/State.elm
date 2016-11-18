module State exposing (..)

import Types exposing (..)
import Join.State
import Player.State
import Agents exposing (Player, nullPlayer)
import Debug exposing (log)
import Messages exposing (messageTypes, welcomeMessage, deltaMessage, updateMessage)
import Ports exposing (outboundSocket)
import Debug exposing (log, crash)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TaskDone () ->
            ( model, Cmd.none )

        NewMessage str ->
            let
                s =
                    log "msg: " str
            in
                ( model, Cmd.none )

        ScreenSizeChanged dim ->
            ( { model | screen = (log "screen size: " dim) }, Cmd.none )

        InboundMessage msg ->
            if msg.messageType == messageTypes.welcome then
                let
                    maybeWm =
                        welcomeMessage msg
                in
                    case maybeWm of
                        Just wm ->
                            ( { model
                                | joined = True
                                , joinedAt = Just (log "welcome at: " wm.timestamp)
                                , me = Just wm.me
                                , players = wm.players
                                , asteroids = wm.asteroids
                              }
                            , Cmd.none
                            )

                        Nothing ->
                            ( model, Cmd.none )
            else if msg.messageType == messageTypes.delta then
                let
                    maybeDelta =
                        deltaMessage msg
                in
                    case maybeDelta of
                        Just d ->
                            ( { model
                                | players = d.players
                                , asteroids = d.asteroids
                                , score = d.score
                              }
                            , Cmd.none
                            )

                        Nothing ->
                            ( model, Cmd.none )
            else
                ( model, Cmd.none )

        PlayerMsg sub ->
            let
                me =
                    model.me
                        |> Maybe.withDefault nullPlayer

                ( updated, fx ) =
                    Player.State.update sub me model.screen
            in
                ( { model | me = (Just updated) }, (outboundSocket (updateMessage updated)) )

        JoinMsg sub ->
            let
                ( updated, fx ) =
                    --some bug is causing this to fire after we have joined
                    --with sub set to a keycode. All I can do is ignore it and
                    --hopefully it will get fixed.
                    if model.joined then
                        ( model.join, Cmd.none )
                    else
                        Join.State.update (log "sub: " sub) model.join
            in
                ( { model | join = updated }, Cmd.map JoinMsg fx )

module State (..) where

import Types exposing (..)
import Join.State
import Player.State
import Agents exposing (Player)
import Effects exposing (Effects, Never)
import Debug exposing (log)
import Messages exposing (messageTypes, welcomeMessage, deltaMessage)

update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        ScreenSizeChanged dim ->
            ( { model | screen = (log "screen size: " dim) }, Effects.none)
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
                                , asteroids = wm.asteroids }, Effects.none)
                        Nothing ->
                            ( model, Effects.none )
            else if msg.messageType == messageTypes.delta then
                let
                    maybeDelta = deltaMessage msg
                in
                    case maybeDelta of
                        Just d ->
                            ( { model | players = d.players
                                , asteroids = d.asteroids }, Effects.none)
                        Nothing ->
                            ( model, Effects.none )
            else
                ( model, Effects.none)

        PlayerAction sub ->
            let
                (updated, fx) =
                    Player.State.update sub model.me
            in
                ( { model | me = updated }, Effects.map PlayerAction fx )

        JoinAction sub ->
            let
                (updated, fx) =
                    Join.State.update sub model.join
            in
                ( { model | join = updated }, Effects.map JoinAction fx )

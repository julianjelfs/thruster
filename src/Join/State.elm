module Join.State exposing(..)

import Join.Types exposing (..)
import Messages exposing (..)
import Ports exposing (outboundSocket)
import Debug exposing (log)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TaskDone () ->
            (model, Cmd.none )
        UpdateName name ->
            ( { model | name = name }, Cmd.none )
        UpdateTeam team ->
            ( { model | team = team }, Cmd.none )
        JoinGame name team ->
            ( model, outboundSocket (log "joining: " (joinMessage name team)) )

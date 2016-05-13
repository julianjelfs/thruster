module Join.State exposing(..)

import Join.Types exposing (..)
import Messages exposing (..)

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
            let
                fx = Cmd.none
                {-- TODO just use port for this
                fx = Signal.send model.outboundSocketAddress (joinMessage name team)
                    |> Effects.task
                    |> Effects.map TaskDone
                --}
            in
                ( model, fx )

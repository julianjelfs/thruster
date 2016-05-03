module Join.State (..) where

import Join.Types exposing (..)
import Effects exposing (Effects, Never)

update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        TaskDone () ->
            (model, Effects.none )
        UpdateName name ->
            ( { model | name = name }, Effects.none )
        UpdateTeam team ->
            ( { model | team = team }, Effects.none )
        JoinGame name team ->
            let
                fx = Signal.send model.outboundSocketAddress (name ++ " joins the game on the " ++ team ++ " team")
                    |> Effects.task
                    |> Effects.map TaskDone
            in
                ( model, fx )

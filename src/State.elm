module State (..) where

import Types exposing (..)
import Join.State
import Effects exposing (Effects, Never)

update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        InboundMessage msg ->
            ( { model | joined = True }, Effects.none)
        JoinAction sub ->
            let
                (updated, fx) =
                    Join.State.update sub model.join
            in
                ( { model | join = updated }, Effects.map JoinAction fx )

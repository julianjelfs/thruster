module State (..) where

import Types exposing (..)
import Join.State
import Effects exposing (Effects, Never)
import Debug exposing (log)

update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        ScreenSizeChanged dim ->
            ( { model | screen = (log "screen size: " dim) }, Effects.none)
        InboundMessage (time, msg) ->
            ( { model | joined = True, joinedAt = Just time }, Effects.none)
        JoinAction sub ->
            let
                (updated, fx) =
                    Join.State.update sub model.join
            in
                ( { model | join = updated }, Effects.map JoinAction fx )

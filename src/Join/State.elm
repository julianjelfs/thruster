module Join.State exposing(..)

import Join.Types exposing (..)
import Debug exposing (log)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JoinGame name team ->
            ( model, Cmd.none)

module Join.State (..) where

import Join.Types exposing (..)
import Effects exposing (Effects, Never)

update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        JoinGame name team -> 
            ( model, Effects.none )

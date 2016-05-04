module View (..) where

import Types exposing (..)
import Html exposing (..)
import Join.View

view : Signal.Address Action -> Model -> Html
view address model =
    if model.joined then
        h1 [] [ text "Woohoo, welcome to the game!" ]
    else
        div
            []
            [ Join.View.view (Signal.forwardTo address JoinAction) model.join]

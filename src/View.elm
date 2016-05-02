module View (..) where

import Types exposing (..)
import Html exposing (..)

view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ text "Hello" ]

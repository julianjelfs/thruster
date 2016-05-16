module View exposing(..)

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)

view : Model -> Html Msg
view model =
    div [] [ text "is something funny happening" ]

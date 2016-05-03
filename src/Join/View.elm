module Join.View (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Join.Types exposing (..)

view : Signal.Address Action -> Model -> Html
view address model =
    Html.form
        [class "join-form"]
        [ div 
            [] 
            [ label [for "name-field"] [ text "Name" ] 
            , input 
                [ id "name-field"
                , autofocus True
                , placeholder "Enter your name"
                , value model.name ] [] ] 
        , div
            []
            [ label [for "team-field"] [ text "Team" ] 
            , input 
                [ id "team-field"
                , placeholder "Choose your team"
                , value model.team ] [] ]
        , button
            []
            [ text "join the game" ]
        ]

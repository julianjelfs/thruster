module Join.View (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Join.Types exposing (..)
import Json.Decode exposing (succeed)

view : Signal.Address Action -> Model -> Html
view address model =
    Html.form
        [ class "join-form"
        , onWithOptions
            "submit"
            { preventDefault = True
            , stopPropagation = False }
            ( succeed Nothing )
            (\_ -> Signal.message address (JoinGame model.name model.team)) ]
        [ div 
            [] 
            [ label [for "name-field"] [ text "Name" ] 
            , input 
                [ id "name-field"
                , autofocus True
                , on "input" targetValue (\n -> Signal.message address (UpdateName n))
                , placeholder "Enter your name"
                , value model.name ] [] ] 
        , div
            []
            [ label [for "team-field"] [ text "Team" ] 
            , input 
                [ id "team-field"
                , on "input" targetValue (\t -> Signal.message address (UpdateTeam t))
                , placeholder "Choose your team"
                , value model.team ] [] ]
        , button
            [ type' "submit" ]
            [ text "join the game" ]
        ]

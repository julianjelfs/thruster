module Join.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Join.Types exposing (..)
import Json.Decode as Json
import Debug exposing (log)

view : Model -> Html Msg
view model =
    Html.form
        [ class "join-form"
        , onSubmit (JoinGame (log "name: " model.name) model.team)
        ]
        [ div 
            [] 
            [ label [for "name-field"] [ text "Name" ] 
            , input 
                [ id "name-field"
                , autofocus True
                , onInput UpdateName
                , placeholder "Enter your name"
                , value model.name ] [] ] 
        , div
            []
            [ label [for "team-field"] [ text "Team" ]
            , select
                [ class "form-control"
                , id "team"
                , on "change" (Json.map UpdateTeam targetValue) ]
                [ option
                    [value "Blue"] [ text "Blue" ]
                , option
                    [value "Green"] [ text "Green" ]
                ]
            ]
        , button
            [ type' "submit" ]
            [ text "join the game" ]
        ]


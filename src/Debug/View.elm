module Debug.View (..) where

import Html exposing (..)
import Html.Attributes exposing (..)

root player =
    case player of
        Just p ->
            div
                [ class "debug" ]
                [ div [] [ text ("name: " ++ (toString p.name)) ]
                , div [] [ text ("x: " ++ (toString p.x)) ]
                , div [] [ text ("y: " ++ (toString p.y)) ]
                , div [] [ text ("speed: " ++ (toString p.speed)) ]
                , div [] [ text ("a: " ++ (toString p.angle)) ]
                ]
        Nothing ->
            div [] []

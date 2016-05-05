module View (..) where

import Types exposing (..)
import Html exposing (..)
import Join.View
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)

shapes (w, h) =
    collage w h
        [ ngon 4 75
            |> filled green
            |> move (-10,0)
        , ngon 5 50
            |> filled green
            |> move (50,10)
        ]

view : Signal.Address Action -> Model -> Html
view address model =
    if model.joined then
        div
            []
            [ h1 [] [ Html.text "Woohoo, welcome to the game!" ]
            , fromElement (shapes model.screen) ]
    else
        div
            []
            [ Join.View.view (Signal.forwardTo address JoinAction) model.join]

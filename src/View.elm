module View (..) where

import Types exposing (..)
import Html exposing (..)
import Join.View
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Starfield.View exposing (starfield)

canvas {joinedAt} dim =
    let
        (w, h) = dim
    in
        collage w h (starfield joinedAt dim)
            |> fromElement

view : Signal.Address Action -> Model -> Html
view address model =
    if model.joined then
        div
            []
            [ h1 [] [ Html.text "Woohoo, welcome to the game!" ]
            , canvas model model.screen ]
    else
        div
            []
            [ Join.View.view (Signal.forwardTo address JoinAction) model.join]

module View (..) where

import Types exposing (..)
import Html exposing (..)
import Join.View
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Starfield.View as Starfield
import Asteroid.View as Asteroid
import List

canvas {joinedAt, asteroids} dim =
    let
        (w, h) = dim
        stars = Starfield.root joinedAt dim
        asts = Asteroid.root asteroids dim
    in
        collage w h (List.append stars asts)
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

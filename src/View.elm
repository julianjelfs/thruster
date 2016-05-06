module View (..) where

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Join.View
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Starfield.View as Starfield
import Asteroid.View as Asteroid
import Player.View as Player
import List

canvas {joinedAt, asteroids, players} dim =
    let
        (w, h) = dim
        stars = Starfield.root joinedAt dim
        asts = Asteroid.root asteroids dim
        plyr = Player.root players dim
        agents = List.concat [stars, asts, plyr]
    in
        collage w h agents
            |> fromElement

view : Signal.Address Action -> Model -> Html
view address model =
    if model.joined then
        div
            []
            [ h1 [ class "welcome" ] [ Html.text "Woohoo, welcome to the game!" ]
            , canvas model model.screen ]
    else
        div
            []
            [ Join.View.view (Signal.forwardTo address JoinAction) model.join]

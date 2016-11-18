module View exposing (..)

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Join.View
import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Starfield.View as Starfield
import Asteroid.View as Asteroid
import Player.View as Player
import Goal.View as Goal
import Hud.View as Hud
import Agents exposing (Player, nullPlayer)
import List
import Debug.View
import Config exposing (greenGoal, blueGoal)


canvas { joinedAt, asteroids, players, me, score } dim =
    let
        ( w, h ) =
            dim

        goals =
            [ Goal.root score.blue "BLUE" blue (blueGoal dim)
            , Goal.root score.green "GREEN" green (greenGoal dim)
            ]

        stars =
            Starfield.root joinedAt dim

        asts =
            Asteroid.root asteroids dim

        definitelyMe =
            (Maybe.withDefault nullPlayer me)

        plyr =
            Player.root [ definitelyMe ] dim

        notMe =
            List.filter (\p -> p.id /= definitelyMe.id) players

        agents =
            List.concat [ stars, asts, plyr, (Player.root notMe dim), [ (Hud.root definitelyMe dim) ], goals ]
    in
        collage w h agents
            |> toHtml


view : Model -> Html Msg
view model =
    if model.joined then
        div
            []
            [ h1 [ class "welcome" ] [ Html.text "Woohoo, welcome to the game!" ]
            , canvas model model.screen
            , Debug.View.root model.me
            ]
    else
        div
            []
            [ Html.map JoinMsg (Join.View.view model.join) ]

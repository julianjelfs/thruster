module Main exposing(..)

import Types exposing (..)
import View exposing (view)
import State exposing (update)
import Task
import Window
import Html.App as Html
import Debug exposing (log)
import Player.Subs exposing (..)

-- START APP
init : ( Model, Cmd Msg )
init =
  ( initialModel, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    --the event loop sub is causing everything to go haywire
    Sub.batch [ keyDown
              , keyUp
              , eventLoop
              ]

main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

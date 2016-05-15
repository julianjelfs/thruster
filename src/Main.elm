module Main exposing(..)

import Types exposing (..)
import View exposing (view)
import State exposing (update)
import Task
import Window
import Html.App as Html
import Messages exposing (..)
import Debug exposing (log)
import Player.Subs exposing (..)
import Ports exposing (inboundSocket)

-- START APP
init : ( Model, Cmd Msg )
init =
  ( initialModel, initialWindowSize )

initialWindowSize : Cmd Msg
initialWindowSize =
    Window.size
        |> Task.map (\s -> (s.width, s.height))
        |> Task.perform TaskDone ScreenSizeChanged

subscriptions : Model -> Sub Msg
subscriptions model =
    --the event loop sub is causing everything to go haywire
    Sub.batch [ keyDown
              , keyUp
              , eventLoop
              , windowResize
              , (inboundSocket InboundMessage)
              ]

main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

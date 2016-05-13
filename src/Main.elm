module Main exposing(..)

import Types exposing (..)
import View exposing (view)
import State exposing (update)
import Task
import Window
import Html.App as Html
import Messages exposing (..)
import Debug exposing (log)
import Time exposing (timestamp)
import Player.Signals exposing (..)

-- START APP
init : ( Model, Cmd Msg )
init =
  ( initialModel initialWindowSize, Cmd.none )

main : Signal.Signal Html
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }

port outboundSocket : Signal Message
port outboundSocket =
    outboundSocketMailbox.signal

port inboundSocket : Signal Message

-- yuck this is a hack but it appears to me required
port initialWindowSize : (Int, Int)

inboundSocketSignal: Signal Msg
inboundSocketSignal =
    Signal.map InboundMessage (timestamp inboundSocket)

--this needs to be a subscription
screenSizeSignal: Signal Msg
screenSizeSignal =
    Signal.map ScreenSizeChanged Window.dimensions

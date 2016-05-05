module Main (..) where

import Types exposing (..)
import View exposing (view)
import State exposing (update)
import Effects exposing (Effects, Never)
import Task
import Mailboxes exposing (..)
import StartApp
import Window
import Html exposing (..)
import Messages exposing (..)
import Signal.Extra exposing (foldp')
import Debug exposing (log)
import Time exposing (timestamp)

-- START APP
init : ( Model, Effects Action )
init =
  ( initialModel initialWindowSize outboundSocketMailbox.address, Effects.none )

app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , inputs = [inboundSocketSignal, screenSizeSignal]
    , update = update
    , view = view
    }

main : Signal.Signal Html
main =
  app.html

port runner : Signal (Task.Task Never ())
port runner =
  app.tasks

port outboundSocket : Signal Message
port outboundSocket =
    outboundSocketMailbox.signal

port inboundSocket : Signal Message

-- yuck this is a hack but it appears to me required
port initialWindowSize : (Int, Int)

inboundSocketSignal: Signal Action
inboundSocketSignal =
    Signal.map InboundMessage (timestamp inboundSocket)

screenSizeSignal: Signal Action
screenSizeSignal =
    Signal.map ScreenSizeChanged Window.dimensions

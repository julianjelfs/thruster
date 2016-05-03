module Main (..) where

import Types exposing (..)
import View exposing (view)
import State exposing (update)
import Effects exposing (Effects, Never)
import Task
import Mailboxes exposing (..)
import StartApp
import Html exposing (..)

-- START APP
init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )

app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , inputs = []
    , update = update
    , view = view
    }

main : Signal.Signal Html
main =
  app.html

port runner : Signal (Task.Task Never ())
port runner =
  app.tasks

port outboundSocket : Signal String
port outboundSocket =
    outboundSocketMailbox.signal

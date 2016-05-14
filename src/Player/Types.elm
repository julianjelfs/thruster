module Player.Types exposing(..)

import Messages exposing (..)
import Time
import Keyboard exposing (KeyCode)

type Msg =
    KeyDown KeyCode
    | KeyUp KeyCode
    | Tick Time.Time
    | Move { x: Int, y: Int }


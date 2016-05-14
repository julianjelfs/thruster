module Player.Types exposing(..)

import Messages exposing (..)
import Time

type Msg =
    Tick Time.Time
    | Move { x: Int, y: Int }


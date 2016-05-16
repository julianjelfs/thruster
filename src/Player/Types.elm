module Player.Types exposing(..)

import Time
import Keyboard exposing (KeyCode)

type Msg =
    KeyDown KeyCode
    | KeyUp KeyCode
    | Tick Time.Time


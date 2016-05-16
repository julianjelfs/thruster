module Player.Subs exposing(..)

import Keyboard
import Player.Types
import Types exposing (..)
import Time exposing (every, millisecond, second)
import Window exposing (resizes)
import Keyboard exposing (downs, ups)
import AnimationFrame exposing (diffs)

eventLoop: Sub Msg
eventLoop =
    diffs Player.Types.Tick
        |> Sub.map PlayerMsg

keyDown: Sub Msg
keyDown =
    downs Player.Types.KeyDown
        |> Sub.map PlayerMsg

keyUp: Sub Msg
keyUp =
    ups Player.Types.KeyUp
        |> Sub.map PlayerMsg

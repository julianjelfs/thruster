module Player.Subs exposing(..)

import Keyboard
import Player.Types
import Types exposing (..)
import Time exposing (every, millisecond, second)
import Window exposing (resizes)
import Keyboard exposing (downs, ups)

eventLoop: Sub Msg
eventLoop =
    every (millisecond * 16) Player.Types.Tick
        |> Sub.map PlayerMsg

windowResize: Sub Msg
windowResize =
   resizes (\s -> ScreenSizeChanged (s.width, s.height))

keyDown: Sub Msg
keyDown =
    downs Player.Types.KeyDown
        |> Sub.map PlayerMsg

keyUp: Sub Msg
keyUp =
    ups Player.Types.KeyUp
        |> Sub.map PlayerMsg

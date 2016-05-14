module Player.Subs exposing(..)

import Keyboard
import Player.Types
import Types exposing (..)
import Time exposing (every, millisecond)
import Window exposing (resizes)

-- not sure what we do with all this stuff

{--
arrowsOrWasd =
    Signal.merge Keyboard.arrows Keyboard.wasd

toPlayerMsg:(a -> Player.Types.Msg) -> a -> Msg
toPlayerMsg pa sig =
    sig |> pa |> PlayerMsg

moveSignal: Signal Msg
moveSignal =
    (Signal.sampleOn (Time.fps 60) arrowsOrWasd)
        |> Signal.map (toPlayerMsg Player.Types.Move)
--}

eventLoop: Sub Msg
eventLoop =
    every (millisecond * 16) Player.Types.Tick
        |> Sub.map PlayerMsg

windowResize: Sub Msg
windowResize =
   resizes (\s -> ScreenSizeChanged (s.width, s.height))


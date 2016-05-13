module Player.Signals exposing(..)

import Keyboard
import Player.Types
import Types exposing (..)
import Time

-- not sure what we do with all this stuff

arrowsOrWasd =
    Signal.merge Keyboard.arrows Keyboard.wasd

toPlayerMsg:(a -> Player.Types.Msg) -> a -> Msg
toPlayerMsg pa sig =
    sig |> pa |> PlayerMsg

moveSignal: Signal Msg
moveSignal =
    (Signal.sampleOn (Time.fps 60) arrowsOrWasd)
        |> Signal.map (toPlayerMsg Player.Types.Move)

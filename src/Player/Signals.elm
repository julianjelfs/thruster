module Player.Signals (..) where

import Keyboard
import Player.Types
import Types exposing (..)
import Time

arrowsOrWasd =
    Signal.merge Keyboard.arrows Keyboard.wasd

toPlayerAction:(a -> Player.Types.Action) -> a -> Action
toPlayerAction pa sig =
    sig |> pa |> PlayerAction

moveSignal: Signal Action
moveSignal =
    (Signal.sampleOn (Time.fps 60) arrowsOrWasd)
        |> Signal.map (toPlayerAction Player.Types.Move)

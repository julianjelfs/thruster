module Types (..) where

import Join.Types
import Messages exposing (..)

type Action =
    JoinAction Join.Types.Action
    | InboundMessage Message
    | ScreenSizeChanged (Int, Int)

type alias Model =
    { join: Join.Types.Model
    , joined: Bool
    , screen: (Int, Int)
    }

initialModel : (Int, Int) -> Signal.Address Message -> Model
initialModel screenSize address =
    { join = (Join.Types.initialModel address)
    , joined = False
    , screen = screenSize
    }

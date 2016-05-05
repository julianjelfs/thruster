module Types (..) where

import Join.Types
import Messages exposing (..)
import Agents exposing (..)
import Time

type Action =
    JoinAction Join.Types.Action
    | InboundMessage (Time.Time, Message)
    | ScreenSizeChanged (Int, Int)

type alias Model =
    { join: Join.Types.Model
    , joined: Bool
    , joinedAt: Maybe Time.Time
    , screen: (Int, Int)
    , me: Maybe Player
    , players: List Player
    , asteroids: List Asteroid
    }

initialModel : (Int, Int) -> Signal.Address Message -> Model
initialModel screenSize address =
    { join = (Join.Types.initialModel address)
    , joined = False
    , joinedAt = Nothing
    , screen = screenSize
    , me = Nothing
    , players = []
    , asteroids = []
    }

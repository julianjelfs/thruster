module Types exposing(..)

import Join.Types
import Player.Types
import Messages exposing (..)
import Agents exposing (..)
import Time

type Msg =
    JoinMsg Join.Types.Msg
    | PlayerMsg Player.Types.Msg
    | InboundMessage (Time.Time, Message)
    | ScreenSizeChanged (Int, Int)
    | TaskDone ()

type alias Model =
    { join: Join.Types.Model
    , joined: Bool
    , joinedAt: Maybe Time.Time
    , screen: (Int, Int)
    , me: Maybe Player
    , players: List Player
    , asteroids: List Asteroid
    }

initialModel : (Int, Int) -> Model
initialModel screenSize address =
    { join = (Join.Types.initialModel address)
    , joined = False
    , joinedAt = Nothing
    , screen = screenSize
    , me = Nothing
    , players = []
    , asteroids = []
    }

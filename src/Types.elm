module Types exposing(..)

import Join.Types
import Player.Types
import Messages exposing (..)
import Agents exposing (..)
import Time

type Msg =
    JoinMsg Join.Types.Msg
    | PlayerMsg Player.Types.Msg
    | InboundMessage Message
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

initialModel : Model
initialModel =
    { join = Join.Types.initialModel
    , joined = False
    , joinedAt = Nothing
    , screen = (0,0)
    , me = Nothing
    , players = []
    , asteroids = []
    }

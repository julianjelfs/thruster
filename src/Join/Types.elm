module Join.Types (..) where

import Messages exposing (..)

type Action =
    TaskDone ()
    | JoinGame String String
    | UpdateName String
    | UpdateTeam String

type alias Model =
  { name: String
  , team: String
  , outboundSocketAddress: Signal.Address Message
  }

initialModel : Signal.Address Message -> Model
initialModel address =
  Model "" "" address

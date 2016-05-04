module Types (..) where

import Join.Types
import Messages exposing (..)

type Action =
    JoinAction Join.Types.Action
    | InboundMessage Message

type alias Model =
    { join: Join.Types.Model
    , joined: Bool }

initialModel : Signal.Address Message -> Model
initialModel address =
    { join = (Join.Types.initialModel address)
    , joined = False }

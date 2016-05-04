module Types (..) where

import Join.Types
import Messages exposing (..)

type Action
  = JoinAction Join.Types.Action

type alias Model =
    { join: Join.Types.Model }

initialModel : Signal.Address Message -> Model
initialModel address =
    { join = (Join.Types.initialModel address)  }

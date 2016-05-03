module Types (..) where

import Join.Types

type Action
  = JoinAction Join.Types.Action

type alias Model =
    { join: Join.Types.Model }

initialModel : Signal.Address String -> Model
initialModel address =
    { join = (Join.Types.initialModel address)  }

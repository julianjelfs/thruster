module Types (..) where

import Join.Types

type Action
  = JoinAction Join.Types.Action

type alias Model =
    { join: Join.Types.Model }

initialModel : Model
initialModel =
    { join = Join.Types.initialModel }

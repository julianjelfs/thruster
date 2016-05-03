module Join.Types (..) where

type Action
  = JoinGame String String

type alias Model =
  { name: String
  , team: String
  }

initialModel : Model
initialModel =
  Model "" ""

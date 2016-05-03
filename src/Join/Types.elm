module Join.Types (..) where

type Action =
    JoinGame String String
    | UpdateName String
    | UpdateTeam String

type alias Model =
  { name: String
  , team: String
  }

initialModel : Model
initialModel =
  Model "" ""

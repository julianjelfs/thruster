module Join.Types (..) where

type Action =
    TaskDone ()
    | JoinGame String String
    | UpdateName String
    | UpdateTeam String

type alias Model =
  { name: String
  , team: String
  , outboundSocketAddress: Signal.Address String
  }

initialModel : Signal.Address String -> Model
initialModel address =
  Model "" "" address

module Join.Types exposing(..)

type Msg =
    JoinGame String String

type alias Model =
  { name: String
  , team: String
  }

initialModel : Model
initialModel =
  Model "" "Blue"

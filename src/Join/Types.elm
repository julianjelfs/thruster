module Join.Types exposing (..)

import Messages exposing (..)


type Msg
    = TaskDone ()
    | JoinGame String String
    | UpdateName String
    | UpdateTeam String


type alias Model =
    { name : String
    , team : String
    }


initialModel : Model
initialModel =
    Model "" "Blue"

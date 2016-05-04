module Messages (..) where

import Json.Encode as Encode

type alias Message =
    { messageType: Int
    , payload: Encode.Value
    }

joinEncoder: String -> String -> Encode.Value
joinEncoder name team =
    Encode.object
        [ ("name", Encode.string name)
        , ("team", Encode.string team) ]

emptyMessage: Message
emptyMessage =
    Message 0 Encode.null

joinMessage: String -> String -> Message
joinMessage name team =
    Message 1 (joinEncoder name team)

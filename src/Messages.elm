module Messages (..) where

import Json.Encode

type alias Message =
    { messageType: Int
    , payload: Json.Encode.Value
    }

emptyMessage: Message
emptyMessage =
    Message 0 Json.Encode.null

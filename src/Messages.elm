module Messages (..) where

import Json.Encode as Encode

type alias MessageTypes =
    { empty: Int
    , join: Int
    , welcome: Int
    , update: Int
    , delta: Int
    }

messageTypes: MessageTypes
messageTypes =
    MessageTypes 0 1 2 3 4

type alias Message =
    { messageType: Int
    , payload: Encode.Value
    }

emptyMessage: Message
emptyMessage =
    Message messageTypes.empty Encode.null

joinMessage: String -> String -> Message
joinMessage name team =
    Message
        messageTypes.join
        (Encode.object
                [ ("name", Encode.string name)
                , ("team", Encode.string team) ])

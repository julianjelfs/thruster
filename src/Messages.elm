module Messages exposing(..)

import Json.Encode as Encode
import Json.Decode as Decode exposing ((:=))
import Agents exposing (..)
import Debug exposing (log)
import Time exposing (Time)

type alias MessageTypes =
    { empty: Int
    , join: Int
    , welcome: Int
    , update: Int
    , delta: Int
    }

type alias UpdateMessage =
    { me: Player }

type alias WelcomeMessage =
    { me: Player
    , players: List Player
    , asteroids: List Asteroid
    , timestamp: Time
    }

type alias DeltaMessage =
    { players: List Player
    , asteroids: List Asteroid
    }

messageTypes: MessageTypes
messageTypes =
    MessageTypes 0 1 2 3 4

type alias Message =
    { messageType: Int
    , payload: Encode.Value
    }


playerCtr a b c d e f g =
    Player a b c d e f g 0 0 {x=0,y=0} 100

playerDecoder =
    Decode.object7
        playerCtr
        ("x" := Decode.float)
        ("y" := Decode.float)
        ("angle" := Decode.float)
        ("thrusting" := Decode.bool)
        ("id" := Decode.string)
        ("name" := Decode.string)
        ("team" := Decode.string)

asteroidDecoder =
    Decode.object8
        Asteroid
        ("x" := Decode.float)
        ("y" := Decode.float)
        ("c" := Decode.string)
        ("id" := Decode.int)
        ("r" := Decode.float)
        ("a" := Decode.float)
        ("aa" := Decode.float)
        ("ra" := Decode.float)

welcomeMessage: Message -> Maybe WelcomeMessage
welcomeMessage msg =
    if msg.messageType == messageTypes.welcome then
        let
            result =
                Decode.decodeValue
                    (Decode.object4
                        WelcomeMessage
                        ("me" := playerDecoder)
                        ("players" := Decode.list playerDecoder)
                        ("asteroids" := Decode.list asteroidDecoder)
                        ("timestamp" := Decode.float))
                    msg.payload
        in
            case result of
                Ok wm -> Just wm
                Err err -> Nothing
    else
        Nothing

deltaMessage: Message -> Maybe DeltaMessage
deltaMessage msg =
    if msg.messageType == messageTypes.delta then
        let
            result =
                Decode.decodeValue
                    (Decode.object2
                        DeltaMessage
                        ("players" := Decode.list playerDecoder)
                        ("asteroids" := Decode.list asteroidDecoder))
                    msg.payload
        in
            case result of
                Ok m -> Just m
                Err err -> Nothing
    else
        Nothing

emptyMessage: Message
emptyMessage =
    Message messageTypes.empty Encode.null

updateMessage: Player -> Message
updateMessage player =
    Message
        messageTypes.update
        (Encode.object
            [ ("id", Encode.string player.id)
            , ("x", Encode.float player.x)
            , ("y", Encode.float player.y)
            , ("angle", Encode.float player.angle)
            , ("thrusting", Encode.bool player.thrusting) ])

joinMessage: String -> String -> Message
joinMessage name team =
    Message
        messageTypes.join
        (Encode.object
                [ ("name", Encode.string name)
                , ("team", Encode.string team) ])

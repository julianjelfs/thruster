module Messages exposing (..)

import Json.Encode as Encode
import Json.Decode as Decode exposing (field)
import Agents exposing (..)
import Debug exposing (log)
import Time exposing (Time)


type alias MessageTypes =
    { empty : Int
    , join : Int
    , welcome : Int
    , update : Int
    , delta : Int
    }


type alias UpdateMessage =
    { me : Player }


type alias WelcomeMessage =
    { me : Player
    , players : List Player
    , asteroids : List Asteroid
    , timestamp : Time
    }


type alias DeltaMessage =
    { players : List Player
    , asteroids : List Asteroid
    , score : Score
    }


messageTypes : MessageTypes
messageTypes =
    MessageTypes 0 1 2 3 4


type alias Message =
    { messageType : Int
    , payload : Encode.Value
    }


vectorDecoder =
    Decode.map2
        Vector
        (field "x" Decode.float)
        (field "y" Decode.float)


playerCtr a b c d e f g =
    Player a b c d e f g 0 0 { x = 0, y = 0 } 100


playerDecoder =
    Decode.map7
        playerCtr
        (field "x" Decode.float)
        (field "y" Decode.float)
        (field "angle" Decode.float)
        (field "thrusting" Decode.bool)
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "team" Decode.string)


asteroidDecoder =
    Decode.map8
        Asteroid
        (field "x" Decode.float)
        (field "y" Decode.float)
        (field "c" Decode.string)
        (field "id" Decode.int)
        (field "r" Decode.float)
        (field "aa" Decode.float)
        (field "ra" Decode.float)
        (Decode.maybe (field "v" vectorDecoder))


welcomeMessage : Message -> Maybe WelcomeMessage
welcomeMessage msg =
    if msg.messageType == messageTypes.welcome then
        let
            result =
                Decode.decodeValue
                    (Decode.map4
                        WelcomeMessage
                        (field "me" playerDecoder)
                        (field "players" (Decode.list playerDecoder))
                        (field "asteroids" (Decode.list asteroidDecoder))
                        (field "timestamp" Decode.float)
                    )
                    msg.payload
        in
            case result of
                Ok wm ->
                    Just wm

                Err err ->
                    Nothing
    else
        Nothing


deltaMessage : Message -> Maybe DeltaMessage
deltaMessage msg =
    if msg.messageType == messageTypes.delta then
        let
            result =
                Decode.decodeValue
                    (Decode.map3
                        DeltaMessage
                        (field "players" (Decode.list playerDecoder))
                        (field "asteroids" (Decode.list asteroidDecoder))
                        (field "scores"
                            (Decode.map2
                                Score
                                (field "blue" Decode.int)
                                (field "green" Decode.int)
                            )
                        )
                    )
                    msg.payload
        in
            case result of
                Ok m ->
                    Just m

                Err err ->
                    let
                        e =
                            log "Error: " err
                    in
                        Nothing
    else
        Nothing


emptyMessage : Message
emptyMessage =
    Message messageTypes.empty Encode.null


updateMessage : Player -> Message
updateMessage player =
    Message
        messageTypes.update
        (Encode.object
            [ ( "id", Encode.string player.id )
            , ( "x", Encode.float player.x )
            , ( "y", Encode.float player.y )
            , ( "angle", Encode.float player.angle )
            , ( "thrusting", Encode.bool player.thrusting )
            ]
        )


joinMessage : String -> String -> Message
joinMessage name team =
    Message
        messageTypes.join
        (Encode.object
            [ ( "name", Encode.string name )
            , ( "team", Encode.string team )
            ]
        )

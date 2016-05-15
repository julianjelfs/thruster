module Agents exposing(..)

type alias Player =
    { x: Float
    , y: Float
    , angle: Float
    , thrusting: Bool
    , id: String
    , name: String
    , team: String
    , speed: Float
    , movingAngle: Float
    , arrows: {x:Int, y:Int}
    }


nullPlayer =
    Player 0 0 0 False "" "" "" 0 0 { x = 0, y = 0 }

type alias Asteroid =
    { x: Float
    , y: Float
    , colour: String
    , id: Int
    , radius: Float
    , angle: Float
    }

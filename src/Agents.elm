module Agents (..) where

type alias Player =
    { x: Float
    , y: Float
    , angle: Float
    , thrusting: Bool
    , id: String
    , name: String
    , team: String
    , dx: Float
    , dy: Float
    , da: Float
    }

nullPlayer =
    Player 0 0 0 False "" "" "" 0 0 0

type alias Asteroid =
    { x: Float
    , y: Float
    , colour: String
    , id: Int
    , radius: Float
    , angle: Float
    }

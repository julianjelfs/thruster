module Agents (..) where

type alias Player =
    { x: Float
    , y: Float
    , angle: Float
    , thrusting: Bool
    , id: String
    , name: String
    , team: String
    }

type alias Asteroid =
    { x: Float
    , y: Float
    , colour: String
    , id: Int
    , radius: Float
    }

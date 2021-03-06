module Player.View exposing (..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import List exposing (map)
import Debug exposing (log)
import Text exposing (..)
import String exposing (..)
import Config exposing (relativePosition)


grad =
    linear ( 0, 0 ) ( 100, 300 ) [ ( 1, yellow ), ( 0, yellow ) ]


teamColour p =
    if p.team == "Green" then
        green
    else if p.team == "Blue" then
        blue
    else
        yellow


thrustCone =
    polygon
        [ ( 0, 0 )
        , ( 600, 150 )
        , ( 600, -150 )
        ]


rocket =
    polygon
        ([ ( -20, 0 )
         , ( -8, 5 )
         , ( -12, 11 )
         , ( 6, 11 )
         , ( 8, 12 )
         , ( 8, 15 )
         , ( 20, 20 )
         , ( 20, -20 )
         , ( 8, -15 )
         , ( 8, -12 )
         , ( 6, -11 )
         , ( -12, -11 )
         , ( -8, -5 )
         ]
            |> List.map (\( x, y ) -> ( (x - 5), y ))
        )


filledRocket tc =
    rocket |> filled tc


filledCone =
    thrustCone
        |> filled yellow
        |> alpha 0.2


player dim p =
    let
        name =
            fromString (p.name |> (String.left 1) |> String.toUpper)
                |> centered
                |> toForm

        tc =
            teamColour p

        completeRocket =
            if p.thrusting then
                group [ filledCone, filledRocket tc ]
            else
                filledRocket tc
    in
        group [ completeRocket, name ]
            --|> move (p.x, p.y)
            |>
                move (relativePosition dim p)
            |> rotate (degrees p.angle)


root players ( w, h ) =
    players
        |> List.map (player ( w, h ))

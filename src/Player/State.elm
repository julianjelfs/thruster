module Player.State (..) where

import Player.Types exposing (..)
import Agents exposing (Player)
import Effects exposing (Effects, Never)
import Debug exposing (log)

tolerance = 0.5
rotationSpeed = 10

newPosition speed angle =
    let
        dx = speed * (cos angle)
        dy = speed * (sin angle)
    in
        (dx, dy)


constrain: Float -> Int -> Float
constrain dim limit =
    let
        limitf = toFloat limit
        upper = limitf / 2
        lower = negate upper
    in
        if dim > upper then
            lower
        else if dim < lower then
            upper
        else
            dim

currentSpeed {speed} yf =
    if yf /= 0 then
        if yf < 0 then
            -15
        else
            15
    else if (abs speed) > tolerance then
        speed * 0.95
    else
        0

currentAngle {movingAngle} yf angle =
    if yf /= 0 then
        angle
    else
        movingAngle


update : Action -> Player -> (Int, Int) -> ( Player, Effects Action )
update action player (w, h) =
    case action of
        Move wasd ->
            let
                (xf, yf) = (toFloat wasd.x, toFloat wasd.y)
                speed = currentSpeed player yf
                angle = player.angle + (xf * rotationSpeed |> negate)
                movingAngle = currentAngle player yf angle
                (x, y) = (newPosition speed (degrees movingAngle))
                px = constrain player.x w
                py = constrain player.y h
            in
                ( { player |
                    angle = angle
                    , x = px + x
                    , y = py + y
                    , speed = speed
                    , movingAngle = movingAngle
                    }, Effects.none )

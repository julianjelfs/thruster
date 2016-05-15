module Player.State exposing(..)

import Player.Types exposing (..)
import Agents exposing (Player)
import Messages exposing (..)
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

up = 38
down = 40
left = 37
right = 39

updateArrows arrows code inc =
    if code == up then
        { arrows | y = arrows.y + inc }
    else if code == down then
        { arrows | y = arrows.y - inc }
    else if code == left then
        { arrows | x = arrows.x - inc }
    else if code == right then
        { arrows | x = arrows.x + inc }
    else
        arrows

update : Msg -> Player -> (Int, Int) -> ( Player, Cmd Msg )
update msg player (w, h) =
    case msg of
        KeyDown code ->
            let
                arrows = updateArrows player.arrows code 1
            in
                ({player | arrows = arrows}, Cmd.none)
        KeyUp code ->
            let
                arrows = updateArrows player.arrows code -1
            in
                ({player | arrows = arrows}, Cmd.none)
        Tick t ->
            let
                wasd = player.arrows
                (xf, yf) = (toFloat wasd.x, toFloat wasd.y)
                speed = currentSpeed player yf
                angle = player.angle + (xf * rotationSpeed |> negate)
                movingAngle = currentAngle player yf angle
                (x, y) = (newPosition speed (degrees movingAngle))
                px = constrain player.x w
                py = constrain player.y h

                updatedPlayer =
                    { player |
                        angle = angle
                        , x = px + x
                        , y = py + y
                        , speed = speed
                        , movingAngle = movingAngle
                        }
            in
                ( updatedPlayer, Cmd.none )


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
space = 32

updateArrows arrows code inc =
    if code == up then
        { arrows | y = clamp -1 1 (arrows.y + inc) }
    else if code == down then
        { arrows | y = clamp -1 1 (arrows.y - inc) }
    else if code == left then
        { arrows | x = clamp -1 1 (arrows.x - inc) }
    else if code == right then
        { arrows | x = clamp -1 1 (arrows.x + inc) }
    else
        arrows

updateThrust player on code =
    if code == space then
        on
    else
        player.thrusting

constrainAngle a =
    if a < -180 then
        360 + a
    else
        if a > 180 then
            a - 360
        else
            a


update : Msg -> Player -> (Int, Int) -> ( Player, Cmd Msg )
update msg player (w, h) =
    case msg of
        KeyDown code ->
            let
                arrows = updateArrows player.arrows code 1
                thrusting = updateThrust player True code
            in
                ({player | arrows = arrows, thrusting = thrusting}, Cmd.none)
        KeyUp code ->
            let
                arrows = updateArrows player.arrows code -1
                thrusting = updateThrust player False code
            in
                ({player | arrows = arrows, thrusting = thrusting}, Cmd.none)
        Tick t ->
            let
                wasd = player.arrows
                (xf, yf) = (toFloat wasd.x, toFloat wasd.y)
                speed = currentSpeed player yf
                angle = player.angle + (xf * rotationSpeed |> negate) |> constrainAngle
                movingAngle = currentAngle player yf angle
                (x, y) = (newPosition speed (degrees movingAngle))
                px = constrain player.x w
                py = constrain player.y h
                power =
                    clamp 0 100
                        (if player.thrusting then
                            player.power - 1
                        else
                            player.power + 1)

                thrusting =
                    if power > 0 then
                        player.thrusting
                    else
                        False

                updatedPlayer =
                    { player |
                        angle = angle
                        , x = px + x
                        , y = py + y
                        , speed = speed
                        , movingAngle = movingAngle
                        , power = power
                        , thrusting = thrusting
                        }
            in
                ( updatedPlayer, Cmd.none )


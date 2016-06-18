module Config exposing (..)

dimensions =
    ( 1024, 768 )

halfDimensions =
    ( 512, 384 )

blueGoal dim =
    let
        (dw, dh) = halfDimensions |> (scaleTuple 0.7)
    in
        { x = negate dw, y = dh }
            |> (relativePosition dim)

scaleTuple factor (w, h) =
    (w*factor, h*factor)

greenGoal dim =
    let
        (dw, dh) = halfDimensions |> (scaleTuple 0.7)
    in
        { x = dw, y = negate dh }
            |> (relativePosition dim)

--convert position from a % to something relative to the screen dimensions
relativePosition (w, h) {x, y} =
    let
        (dw, dh) = halfDimensions
        tw = (toFloat w) / 2
        th = (toFloat h) / 2
        tx = tw / dw * x
        ty = th / dh * y
    in
        (tx, ty)

--convert screen relative position into %
normalisedPosition (w, h) thing =
    let
        x = (((toFloat w) / 2) / thing.x) * thing.x
        y = (((toFloat h) / 2) / thing.y) * thing.y
    in
        { thing | x = x, y = y }

module Player.Types (..) where

import Messages exposing (..)

type Action =
    Rotate { x: Int, y: Int }


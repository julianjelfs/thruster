module Player.Types (..) where

import Messages exposing (..)

type Action =
    Move { x: Int, y: Int }


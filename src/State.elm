module State (..) where

import Types exposing (..)
import Effects exposing (Effects, Never)

update : Action -> Model -> ( Model, Effects Action )
update action model =
  ( model, Effects.none )

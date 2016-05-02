module State (..) where

import Type exposing (..)

update : Action -> Model -> ( Model, Effects Action )
update action model =
  ( model, Effects.none )

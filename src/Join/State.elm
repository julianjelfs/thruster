module Join.State (..) where

import Join.Types exposing (..)
import Effects exposing (Effects, Never)

update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        UpdateName name ->
            ( { model | name = name }, Effects.none )
        UpdateTeam team ->
            ( { model | team = team }, Effects.none )
        JoinGame name team ->
            -- this is where we post a message to our socket mailbox address
            ( model, Effects.none )

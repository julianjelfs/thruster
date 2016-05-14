port module Ports exposing (..)

import Messages exposing (..)

port outboundSocket : Message -> Cmd msg

port inboundSocket : (Message -> msg) -> Sub msg

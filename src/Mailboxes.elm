module Mailboxes (..) where

import Messages exposing (..)

outboundSocketMailbox: Signal.Mailbox Message
outboundSocketMailbox =
    Signal.mailbox emptyMessage

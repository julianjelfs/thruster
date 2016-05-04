module Mailboxes (..) where

import Messages exposing (..)

outboundSocketMailbox: Signal.Mailbox Message
outboundSocketMailbox =
    Signal.mailbox emptyMessage

inboundSocketMailbox: Signal.Mailbox String
inboundSocketMailbox =
    Signal.mailbox ""

module Mailboxes (..) where

outboundSocketMailbox: Signal.Mailbox String
outboundSocketMailbox =
    Signal.mailbox ""

inboundSocketMailbox: Signal.Mailbox String
inboundSocketMailbox =
    Signal.mailbox ""

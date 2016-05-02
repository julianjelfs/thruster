### Just somewhere to make some development notes

### Signals

We'll need to listen to the keypress signal probably merged with a 60fps signal
We'll need an interop port to receive convert all socket IO messages to a signal

Then the client should be pretty simple. Just place all the elements on the screen where
the server tells us to, and send the signals from the keyboard back to the server as they happen

All the difficult stuff will happen on the server. Should we stick with node or go with clojure?

Going to have to deal with ray tracing at some point. Should actually be ok in 2D.


### Next steps

Introduce Elm to the build system (chore)
Get basic socket comms working between node and Elm via js interop


### figuring out whether an asteroid is affected by thrust

radians between points = atan (dY, dX)

affected = distance < thrust radius
            && angle from rocket between x & y

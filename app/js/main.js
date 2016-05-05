// IMPORT ASSETS
import '../css/App.scss'
import io from 'socket.io-client'

import Elm from '../../src/Main.elm'

const messageTypes = {
    empty: 0,
    join: 1,
    welcome: 2,
    update: 3,
    delta: 4
}

const app = Elm.fullscreen(Elm.Main, {
    inboundSocket: {
        messageType: 0,
        payload: null
    },
    initialWindowSize : [
        document.documentElement.clientWidth,
        document.documentElement.clientHeight
    ]
})

app.ports.outboundSocket.subscribe(msg => {
    switch (msg.messageType) {
        case messageTypes.join: startGame(msg.payload)
            break;
    }
})

let socket

function init(s) {
    return s
}

function setupSocket(sock) {
    sock.on('pong', () => {
        console.log('pong')
    })

    // Handle error.
    sock.on('connect_failed', () => {
        sock.close()
    })

    sock.on('disconnect', () => {
        sock.close()
    })

    // Handle connection.
    sock.on('welcome', (s) => {
        app.ports.inboundSocket.send({
            messageType: messageTypes.welcome,
            payload: s
        })        
    })

    sock.on('update', s => {
        app.ports.inboundSocket.send({
            messageType: messageTypes.delta,
            payload: s
        })
    })
    return sock
}

function startGame({name, team}) {
    socket = setupSocket(io({query: `name=${name}&team=${team}`}))
}

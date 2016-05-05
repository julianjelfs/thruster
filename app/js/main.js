// IMPORT ASSETS
import '../css/App.scss'
import io from 'socket.io-client'

import Elm from '../../src/Main.elm'

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
        case 1: startGame(msg.payload)
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
            messageType: 2,
            payload: s
        })        
    })

    sock.on('update', s => {
    })
    return sock
}

function startGame({name, team}) {
    socket = setupSocket(io({query: `name=${name}&team=${team}`}))
}

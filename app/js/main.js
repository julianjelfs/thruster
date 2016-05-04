// IMPORT ASSETS
import '../css/App.scss'
import io from 'socket.io-client'

import Elm from '../../src/Main.elm'

const mountNode = document.getElementById('main')

const app = Elm.embed(Elm.Main, mountNode)

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
        console.log(`We successfully joined the game and got response ${JSON.stringify(s)}`)
    })

    sock.on('update', s => {
    })
    return sock
}

function startGame({name, team}) {
    socket = setupSocket(io({query: `name=${name}&team=${team}`}))
}

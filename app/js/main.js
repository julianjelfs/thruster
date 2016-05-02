// IMPORT ASSETS
import '../css/App.scss'
import io from 'socket.io-client'

import Elm from '../../src/Main.elm'

const mountNode = document.getElementById('main')

const app = Elm.embed(Elm.Main, mountNode)

console.log('are we getting here yet?')

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
    })

    sock.on('update', s => {
    })
    return sock
}

function startGame(name, team) {
    socket = setupSocket(io({query: `name=${name}&team=${team}`}))
}

// IMPORT ASSETS
import '../css/App.scss'
import io from 'socket.io-client'
import config from '../../server/config'

import Elm from '../../src/Main.elm'

const messageTypes = {
    empty: 0,
    join: 1,
    welcome: 2,
    update: 3,
    delta: 4
}

const app = Elm.Main.fullscreen()
let joined = false

app.ports.outboundSocket.subscribe(msg => {
    switch (msg.messageType) {
        case messageTypes.join: 
            if(!joined) {
                startGame(msg.payload)
                joined = true
            }
            break;
        case messageTypes.update: 
            if(socket) {
                socket.emit('updatePlayer', msg.payload)
            }
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
            payload: Object.assign(s, {timestamp:+new Date()})
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

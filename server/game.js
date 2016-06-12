/** game dimensions are 1000, 1000, 1000
/** game dimensions are 1000, 1000, 1000
 * @type {{start: module.exports.start, addPlayer: module.exports.addPlayer}}
 */

import config from './config'

let asteroids = {},
    players = {},
    scores = {
        green: 0,
        blue: 0
    },
    nextId = 0

function randomNum(min,max) {
    return Math.floor(Math.random()*(max-min+1)+min)
}

function randomAngle() {
    return randomNum(0, 360)
}

function randomAsteroidSize() {
    return randomNum(5, 15)
}

function randomPosition(){
    const [x, y] = config.dimensions
    return {
        x: Math.round(( Math.random() - 0.5 ) * x),
        y: Math.round(( Math.random() - 0.5 ) * y)
    }
}

function middle() {
    return {
        x: 250,
        y: 250
    }
}

function addPlayer(player) {
    let p = players[player.id]
    if (!p) {
        p = Object.assign({
            angle: config.startAngle,
            thrusting: false
        }, player, randomPosition())
        players[player.id] = p
    }
    return p
}

function randomColour(){
    return '#' + (Math.random() * 0xFFFFFF << 0).toString(16)
}

function repeatedly(n, fn){
    for (let i = 0; i < n; i++){
        fn()
    }
}

function topUpAsteroids(asteroids){
    const shortfall = config.numAsteroids - Object.keys(asteroids).length

    if (shortfall === 0){
        return asteroids
    }

    repeatedly(shortfall, () => {
        const a = createAnAsteroid()
        asteroids[a.id] = a
    })

    console.log(`topped up shortfall of ${shortfall} asteroids`)
    return asteroids
}

function thrustingPlayers(players) {
    return Object.keys(players)
        .filter(k => players[k].thrusting)
        .map(k => players[k])
}

function distance(p, a) {
    const dx = p.x - a.x
    const dy = p.y - a.y
    return Math.sqrt( dx*dx + dy*dy );
}

function angleRadians(p1, p2) {
    return Math.atan2(p2.y - p1.y, p2.x - p1.x)
}

function angleDegrees(p1, p2) {
    return Math.atan2(p2.y - p1.y, p2.x - p1.x) * 180 / Math.PI
}

function degreesToRadians(degrees) {
    return degrees * Math.PI / 180
}

function outOfBounds(asteroid, dimensions) {
    return beyondLimit(asteroid.x, dimensions[0])
        || beyondLimit(asteroid.y, dimensions[1])
}

function beyondLimit(dim, limit) {
    const upperLimit = limit / 2,
        lowerLimit = upperLimit * -1
    if(dim > upperLimit) {
        return true
    } else if(dim < lowerLimit) {
        return true
    } else {
        return false
    }
}

function mergeVector(v1, v2) {
    return v1 ? {
        x: (v1.x + v2.x) / 2,
        y: (v1.y + v2.y) / 2
    } : v2
}

function score(goal, asteroid) {
    return distance(goal, asteroid) < config.goalSize - 40
}

/* maths works like this ...
 *           90
 *   180            0
 *  -------------------
 *  -180            0
 *          -90
 *
 * but we sometimes want 0 - 360
 */ 
function normaliseAngle(a) {
    return a < 0 ? a + 360 : a
}
    
function moveAsteroids(asteroids) {
    
    thrustingPlayers(players).forEach(t => {
        Object.keys(asteroids).forEach(k =>
            const a = asteroids[k]
            const d = distance(t, a)
            const a1 = angleDegrees(t, a)
            const a3 = Math.abs(normaliseAngle(a1) - normaliseAngle(t.angle))
            
            if(d < config.thrustRange && a3 < config.thrustAngle) {
                a.v = mergeVector(a.v, newVector(a1))
                a.s = config.thrustSpeed / a.r
            } 
            a.aa = Math.round(a1)
        })
    })

    Object.keys(asteroids).forEach(k => {
        const a = asteroids[k]
        if(Math.abs(a.s) > 0.05) {
            a.x += (a.s * a.v.x)
            a.y += (a.s * a.v.y)
            a.s *= 0.9
        } else {
            a.s = 0
            delete a.v
        }
        if(outOfBounds(a, config.dimensions)) {
            delete asteroids[k]
        } else if(score(config.greenGoal, a)) {
            scores.green += a.r
            delete asteroids[k]
        } else if (score(config.blueGoal, a)) {
            scores.blue += a.r
            delete asteroids[k]
        }
    })
    
    return asteroids
}

function newVector(angle) {
    const a = degreesToRadians(angle)
    return {
        x: Math.cos(a),
        y: Math.sin(a)
    }
}

function delta() {
    const start = new Date()
    asteroids = moveAsteroids(topUpAsteroids(asteroids))
    const end = new Date()
    const time = end.getTime() - start.getTime()
    if(time > 20) {
        console.log(`loop took: ${time} ms, might have a performance problem`)
    }
    return {
        players: Object.values(players),
        asteroids: Object.values(asteroids),
        scores: scores
    }
}

function createAnAsteroid() {
    return Object.assign({
        c: '#ff0000',
        id: ++nextId,
        r: randomAsteroidSize(),
        aa: 0,
        ra: 0,
        s: 0,
        v: null
    }, randomPosition())
}

module.exports = {
    start: fn => {
        console.log('starting game')
        repeatedly(config.numAsteroids, () => {
            const a = createAnAsteroid()
            asteroids[a.id] = a
        })
        setInterval(fn, 1000 / config.updatesPerSecond)
        return delta()
    },
    updatePlayer: (id, player) => {
        players[id] = Object.assign(players[id], player)
    },
    delta: delta,
    removePlayer: id => {
        delete players[id]
    },
    addPlayer: player => {
        return {
            me: addPlayer(player),
            players: Object.values(players),
            asteroids: Object.values(asteroids)
        }
    }
}

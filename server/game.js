/** game dimensions are 1000, 1000, 1000
/** game dimensions are 1000, 1000, 1000
 * @type {{start: module.exports.start, addPlayer: module.exports.addPlayer}}
 */

const config = {
    dimensions: [1000, 1000],
    numAsteroids: 50,
    thrustAngle: 60,
    startAngle: 0,
    updatesPerSecond: 16
}

let asteroids = {},
    players = {},
    nextId = 0

function randomNum(min,max) {
    return Math.floor(Math.random()*(max-min+1)+min)
}

function randomAngle() {
    return randomNum(0, 360)
}

function randomAsteroidSize() {
    return randomNum(10, 25)
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

function delta() {
    //this is where we work out what has changed since the last time we checked
    //and apply all the moving logic 
    //replenish asteroids
    asteroids = topUpAsteroids(asteroids)
    return {
        players: Object.values(players),
        asteroids: Object.values(asteroids)
    }
}

function createAnAsteroid() {
    return Object.assign({
        c: randomColour(),
        id: ++nextId,
        r: randomAsteroidSize(),
        a: randomAngle()
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

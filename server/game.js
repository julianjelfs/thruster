/** game dimensions are 1000, 1000, 1000
/** game dimensions are 1000, 1000, 1000
 * @type {{start: module.exports.start, addPlayer: module.exports.addPlayer}}
 */

const config = {
    dimensions: [1000, 1000],
    numAsteroids: 50,
    thrustAngle: 60,
    startAngle: 0,
    updatesPerSecond: 20
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

function constrainAngle(a) {
    if(a < -180) {
        return 360 + a
    } else {
        if (a > 180){
            return a - 360
        } else {
            return a
        }
    }
}

function moveAsteroids(asteroids) {
    
    Object.keys(asteroids).forEach(k => {
        asteroids[k].c = '#ff0000'
    })
    
    const thrusting = thrustingPlayers(players)
    if(thrusting.length === 0) {
        return asteroids
    }
    
    thrusting.forEach(t => {
        Object.keys(asteroids).forEach(k => {
            const a = asteroids[k]
            
            const d = distance(t, a)
            const a1 = angleDegrees(t, a)
            const a2 = a1 - t.angle
            const a3 = Math.abs(constrainAngle(a2))
            
            if(d < 650 && a3 < 20) {
                a.c = '#00FF00'
            } 
            a.aa = Math.round(a1)
            a.ra = Math.round(a2)
        })
    })
    
    return asteroids
}

function delta() {
    //this is where we work out what has changed since the last time we checked
    //and apply all the moving logic 
    //replenish asteroids
    asteroids = moveAsteroids(topUpAsteroids(asteroids))
    return {
        players: Object.values(players),
        asteroids: Object.values(asteroids)
    }
}

function createAnAsteroid() {
    return Object.assign({
        c: '#ff0000',
        id: ++nextId,
        r: randomAsteroidSize(),
        a: randomAngle(),
        aa: 0,
        ra: 0
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

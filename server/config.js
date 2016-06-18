const config = {
    dimensions: [1024, 768],
    numAsteroids: 30,
    thrustAngle: 20,
    startAngle: 0,
    updatesPerSecond: 20,
    thrustSpeed : 50,
    thrustRange : 650,
    goalSize: 150
}

config.blueGoal = {
    x: 1024 / 2 * 0.7 * -1,
    y: 768 / 2 * 0.7
}

config.greenGoal = {
    x: 1024 / 2 * 0.7,
    y: 768 / 2 * 0.7 * -1
}

module.exports = config


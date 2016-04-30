# Thruster

### (previously known as One or more persons and their respective blobs)

A multi-player game using Elm and node js

---

## How to Play

#### Game Controls
- Use WS or up and down arrows to move forward anf backwards in the direction you are pointing
- Use AD or left and right arrows to rotate left and right
- Use spacebar to fire your thruster

#### Gameplay Rules
- Join a team (there must be at least one player on each of the two teams)
- The aim of the game is to herd as many asteroids into your target black hole as possible
- To move asteroids, fire your thrust cannon at them
- Sabotage players on the other team by thrusting them off course or stealing their asteroids
- If you get sucked into either black hole, you are dead
- Thrust cannons are limited and need to be recharged
- bigger asteroids require more thrust to move them, but they get youmore points

---

## How to run

#### Requirements
To run / install this game, you'll need:
- NodeJS with NPM installed.
- socket.IO.
- Express.
- Elm 0.16


#### Downloading the dependencies
After cloning the source code from Github, you need to run the following command to download all the dependencies (socket.IO, express, etc.):

```
npm install
```

#### Running the Server
After downloading all the dependencies, you can run the server with the following command:

```
npm start
```

The game will then be accessible at `http://localhost:3000` or the respective server installed on. The default port is `3000`, however this can be changed in config. 

---

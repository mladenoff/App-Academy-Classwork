const Util = require ("./util");
const MovingObject = require ("./moving_object");



function Asteroid (options) {
  new MovingObject(options);
  this.COLOR = "FFFFFF";
  this.RADIUS = 10;
}
new Asteroid(options);
Util.inherits(Asteroid, MovingObject);

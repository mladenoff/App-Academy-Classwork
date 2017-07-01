

function MovingObject (options) {
  this.pos = options.pos;
  this.vel = options.vel;
  this.radius = options.radius;
  this.color = options.color;
}

MovingObject.prototype.draw = function (ctx) {
  var canvas = document.getElementById('canvas');
  canvas.height = 500;
  canvas.width = 500;
  var context = canvas.getContext('2d');

  context.beginPath();
  context.arc(this.pos[0], this.pos[1], this.radius, 0, 2*Math.PI, true);
  context.fillStyle = this.color;
  context.fill();
};

MovingObject.prototype.move = function () {
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
};

const mo = new MovingObject(
  { pos: [30, 30], vel: [10, 10], radius: 5, color: "#00FF00"}
);

mo.draw();
window.mo = mo;

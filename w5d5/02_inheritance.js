

function MovingObject () {
}
MovingObject.prototype.say = function () {
  console.log("I am moving");
};

function Ship () {

}

function Asteroid () {
  // this.name = "I am asteroid";
}

////Surrogate inherits
// function Surrogate() {}
// Surrogate.prototype = MovingObject.prototype;
// Ship.prototype = new Surrogate ();
// Ship.prototype.constructor = Ship;

////Inherits Type 2
// Function.prototype.inherits = function (parent) {
//   function Surrogate() {}
//   Surrogate.prototype = parent.prototype;
//   this.prototype = new Surrogate ();
//   this.prototype.constructor = this;
// };

////Inherits Type 3
Function.prototype.inherits2 = function(parentClass) {
  this.prototype = Object.create(parentClass.prototype);
  this.prototype.constructor = this;
};

////Test Case
// Ship.prototype = Object.create(MovingObject.prototype);
Ship.inherits2(MovingObject);
let ship = new Ship;
ship.say();

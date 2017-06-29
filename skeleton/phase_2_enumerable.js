Array.prototype.myEach = function(callback){
  for (var i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

// var callback = function(x){
//   return ("Hi, " + x);
// };

Array.prototype.myMap = function(callback){
  let resultArray = [];
  for (var i = 0; i < this.length; i++) {
    resultArray.push(callback(this[i]));
  }
  return resultArray;
};

// ["Bob","kelly", "Sam"].myMap(callback);

Array.prototype.myReduce = function(callback, initialValue){
  // initialValue ||= this[0];
  let i = 0;

  if (!initialValue) {
    initialValue = this[0];
    i = 1;
  }

  while (i < this.length) {
    initialValue = callback(initialValue, this[i]);
    i++;
  }
  return initialValue;
};


var adder = function(x, y) { 
  let sum = x + y;
  return sum;
};

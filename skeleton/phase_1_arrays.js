Array.prototype.uniq = function() {
  let resultArray = [];
  for (var i = 0; i < this.length; i++) {
    if(!resultArray.includes(this[i])) {
      resultArray.push(this[i]);
    }
  }
  return resultArray;
};

// console.log([1,2,2,3].uniq());

Array.prototype.twoSum = function(){
  let resultArray = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        resultArray.push([i,j]);
      }
    }
  }
  return resultArray;
};

Array.prototype.transpose = function() {
  let resultArray = [];

  for (var i = 0; i < this[0].length; i++) {
    let subArray = [];
    for (var j = 0; j < this.length; j++) {
      subArray.push(this[j][i]);
    }
    resultArray.push(subArray);
  }
  return resultArray;
};

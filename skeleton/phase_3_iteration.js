Array.prototype.bubbleSort = function(){
  let sorted = false;
  while (!sorted){
    sorted = true;
    for (var i = 0; i < (this.length - 1); i++) {
      let j = (i + 1);
      if (this[j] < this[i]){
        let temp = this[j];
        this[j] = this[i];
        this[i] = temp;
        sorted = false;
      }
    }
  }
  return this;
};


String.prototype.substrings = function() {

  let arr = this.split("");
  let resultArr = [];

  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length + 1; j++) {
      resultArr.push(arr.slice(i,j).join(""));
    }
  }
  return resultArr;
};

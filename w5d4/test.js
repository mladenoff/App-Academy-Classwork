function SumCalculator() {
  // scope 0
  this.sum = 0;
}

SumCalculator.prototype.addNumbers = function (numbers) {
  // scope 1
  numbers.forEach(number => {
    // scope 2
    console.log(this);
    this.sum += number; // noooo!
  });

  return this.sum;
};

let a = new SumCalculator();
 a.addNumbers([1,2,3]);

function sum (){
  let result = 0;
  for (let i = 0; i < arguments.length; i++){
    result += arguments[i];
  }
  return result;
}

console.log(sum(1, 2, 3, 4));
console.log(sum(1, 2, 3, 4, 5));


function sumRest (...args){
  let result = 0;
  for (let i = 0; i < args.length; i++){
    result += args[i];
  }
  return result;
}

console.log(sumRest(1, 2, 3, 4));
console.log(sumRest(1, 2, 3, 4, 5));


// myBind

Function.prototype.myBind = function (context, ...bindArgs) {
  return (...callArgs) => {
    return this.apply(context, bindArgs.concat(callArgs));
  };
};

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

markov.says("meow", "Ned");
// Markov says meow to Ned!
// true

// bind time args are "meow" and "Kush", no call time args
markov.says.myBind(breakfast, "meow", "Kush")(); //breakfast.says("meow", "Kush")
// Breakfast says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "me"
markov.says.myBind(breakfast)("meow", "a tree");
// Breakfast says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
markov.says.myBind(breakfast, "meow")("Markov"); //breakfast.says("meow", "Markov")
// Breakfast says meow to Markov!
// true

// no bind time args (other than context), call time args are "meow" and "me"
const notMarkovSays = markov.says.myBind(breakfast);
notMarkovSays("meow", "me");
// Breakfast says meow to me!
// true

// curriedSum

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}
sumThree([4, 20, 6]); // == 30

function curriedSum(numArgs){
  const numbers = [];

  function _curriedSum(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return sum(...numbers);
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}


const sumX = curriedSum(4); // const sumX = curriedSumFour;
console.log(sumX(5)(30)(20)(1)); // => 56

// you'll write `Function#curry`!

Function.prototype.curry = function (numArgs) {
  const numbers = [];
  const currying = (num) => {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return this.apply(null, numbers);
    } else {
      return currying;
    }
  };
  return currying;
};

//this is non-fat arrow version:

// Function.prototype.curry = function (numArgs) {
//   const numbers = [];
//   let that = this;
//   function currying (num) {
//     numbers.push(num);
//     if (numbers.length === numArgs) {
//       return that.apply(null, numbers);
//     } else {
//       return currying;
//     }
//   }
//   return currying;
// };



let f1 = sumThree.curry(3);
// tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
f1 = f1(6); // = 30

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6)); // == 30

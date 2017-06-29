const readline = require('readline');

const reader = readline.createInterface({

  input: process.stdin,
  output: process.stdout
});


function addNumbers(sum, numsLeft, completionCallback){
  if (numsLeft > 0){
    reader.question("give me a number", function(input){
      const myInput = parseInt(input);
      sum += myInput;
      console.log(sum);
      numsLeft -= 1;
      addNumbers(sum, numsLeft, completionCallback);
    });
  }

  if (numsLeft === 0){
    completionCallback(sum);
  }

}

// function completionCallback(num)

// end

addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));

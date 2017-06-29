let range = function(start, end){
  if (start===end){
    return [start];
  }
  else{
  return [start].concat(range(start + 1, end));
  }
};

let sumRec = function(arr){
  if (arr.length === 1){
    return arr[0];
  }
  else{
  return arr[0] + sumRec(arr.slice(1,arr.length));
  }
};

let exp1 = function(b, n){
  if (n===0) {
    return 1;
  }
  else {
    return b * exp1(b, n - 1);
  }
};

// WRONG because can't escape the even
// let exp2 = function(b, n){
//   if (n===0) {
//     return 1;
//   }
//   else if (n===1) {
//     return b;
//   }
//   else if (n % 2 === 0){
//     let val1 = exp2(b, n/2);
//     return exp2(val1, 2);
//   }
//   else {
//     let val2 = exp2(b, (n - 1)/2);
//     return b * val2 * val2;
//   }
// };

// Correct code
let exp2 = function(b, n){
  if (n===0) {
    return 1;
  }
  else if (n===1) {
    return b;
  }
  else if (n % 2 === 0){
    let val1 = exp2(b, n/2);
    return  val1 * val1;
  }
  else {
    let val2 = exp2(b, (n - 1)/2);
    return b * val2 * val2;
  }
};

let fib = function(n){
  if (n === 1){
    return [1];
  }
  else if (n === 2){
    return [1,1];
  }
  else {
    let result = fib(n-1);
    result.push(result[result.length - 1] + result[result.length - 2]);
    return result;
  }
};

// let bsearch = function(arr, target) {
//
//   if (arr.length === 1) {
//     if (arr[0] === target){
//       return 0;
//     }
//     else{
//       return -1;
//     }
//   }
//
//   let pivotIdx = Math.floor(arr.length/2);
//
//   if(arr[pivotIdx] > target) {
//     return bsearch(arr.slice(0,pivotIdx), target);
//   }
//   else if (arr[pivotIdx] < target) {
//     return pivotIdx + 1 + bsearch(arr.slice(pivotIdx + 1, arr.length), target);
//   }
//   else {
//     return pivotIdx;
//   }
// };

let bsearch = function(arr, target) {

  if (arr.length === 0) {
    return -1;
  }

  let pivotIdx = Math.floor(arr.length/2);

  if(arr[pivotIdx] > target) {
    return bsearch(arr.slice(0,pivotIdx), target);
  }
  else if (arr[pivotIdx] < target) {
    let result = bsearch(arr.slice(pivotIdx + 1, arr.length), target);
    return result === -1 ? -1 : pivotIdx + 1 + result;
  }
  else if (arr[pivotIdx] === target){
    return pivotIdx;
  }
};

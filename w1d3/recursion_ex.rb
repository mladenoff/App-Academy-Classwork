require 'byebug'

def range(start_num, end_num)
  return [] if end_num < start_num
  return [start_num] if end_num == start_num

  [start_num] + range(start_num + 1, end_num)
end

def sum_array_it(arr)
  total = 0
  arr.each do |num|
    total += num
  end
  total
end

def sum_array_re(arr)
  return arr.first if arr.length <= 1
  arr.first + sum_array_re(arr[1..-1])
end

def exponent(b, n)
  return 1 if n == 0
  b * exponent(b, n-1)
end

def exponent2(b, n)
  return 1 if n == 0
  return b if n == 1
  if n.even?
    exponent(exponent2(b, n/2), 2)
  else
    b * exponent(exponent2(b, (n-1)/2), 2)
  end
end

def deep_dup(arr)
  new_arr = []
  arr.each do |el|
    if el.is_a? Array
      new_arr << deep_dup(el)
    else
      new_arr << el
    end
  end
  new_arr
end

def fibonacci(n)
  current_array = []
  count = 1
  until current_array.length == n
    current_array << find_fib(count)
    count += 1
  end
  current_array
end

def find_fib(n)
  if n <= 2
    return 1
  else
    find_fib(n - 1) + find_fib(n - 2)
  end
end

def subsets(arr)
  return [[]] if arr.length == 0
  value = arr.last
  subsets(arr[0...-1]) + (subsets(arr[0...-1]).each { |subarr| subarr << value })
end

def permutations(arr)
  new_arr = []
  return [arr] if arr.length == 1
  arr.each_with_index do |el, i|
    new_arr += permutations(arr.take(i) + arr.drop(i+1)).map { |subarr| subarr << el }
  end
  new_arr
end

def bsearch(array, target)
  len = array.length / 2
  if array.length == 1
    return target == array.first ? len : nil
  end
  if array[len] == target
    return len
  elsif target < array[len]
    bsearch(array[0...len], target)
  elsif target > array[len]
    return nil unless bsearch(array[len+1..-1], target)
    len + bsearch(array[len+1..-1], target) + 1
  end
end

def merge_sort(arr)
  point = arr.length / 2
  return arr if arr.length <= 1
  arr1 = arr[0...point]
  arr2 = arr[point..-1]
  merge(merge_sort(arr1), merge_sort(arr2))
end

def merge(arr1,arr2)
  output = []
  until arr1.empty? || arr2.empty?
    if arr1.first <= arr2.first
      output << arr1.shift
    else
      output << arr2.shift
    end
  end
  until arr1.empty?
    output << arr1.shift
  end
  until arr2.empty?
    output << arr2.shift
  end
  output
end

def greed_make_change(amount, arr)
  total = amount
  results = []
  arr.each do |coin|
    max = total/coin
    max.times do |i|
      results << coin
    end
    total = total%coin
    break if total == 0
  end
  results
end

def make_better_change(amount, arr)
  return [] if amount == 0
  best_result = nil
  arr.each do |coin|

    choice = (make_better_change(amount - coin, arr.select {|value| value <= amount - coin}) << coin)
    best_result = choice if best_result.nil? || choice.length < best_result.length
  end

  best_result
end

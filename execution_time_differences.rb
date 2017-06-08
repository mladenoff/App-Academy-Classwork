
# O(n^2)
def my_min_slow(arr)
  arr.each do |el|
    my_min = true
    arr.each do |el2|
      next if el == el2
      my_min = false if el > el2
    end
    return el if my_min
  end
end

p my_min_slow([3,2,1,5])

#O(n)
def my_min_fast(arr)
  my_min = arr.first

  arr.each do |el|
    my_min = el if el < my_min
  end

  my_min
end

p my_min_fast([3,2,1,5])


#O(n^2)
def subsum_slow(arr)
  sub_arrs = []

  arr.each_with_index do |el, i|
    (i + 1...arr.length).each do |j|
      sub_arrs << arr[i..j]
    end
  end

  max_sum = sub_arrs.first.inject(:+)
  sub_arrs.each do |sub_arr|
    potential = sub_arr.inject(:+)
    max_sum = potential if potential > max_sum
  end

  max_sum
end

p subsum_slow([2, 3, -6, 7, -6, 7])

# p [2, 3, -6, 7, -6, 7]


#O(n)
def subsum_fast(arr)
  max_subsum = arr.first

  unchecked = false

  until unchecked

  end





end

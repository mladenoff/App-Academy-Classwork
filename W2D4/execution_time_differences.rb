
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
  last = nil

  arr.all? { |n| return arr.max if n < 1 }
  arr[1..-1].each do |n|
    if last
      if last < 0
        last = n
      elsif last > 0
        last = last + n
      end

      if last > max_subsum
        max_subsum = last
        last = nil
      end

    else
      checking = max_subsum + n
      if checking >= max_subsum
        max_subsum = checking
      elsif checking != 0
        last = checking
      end
    end
  end

  max_subsum
end

list = [2, 3, -6, 7, -6, 7]
what = subsum_fast(list)
puts "I am the sum #{what}"

duh = [-5, -1, -3]
p subsum_fast(duh)

# #O(n)
# def subsum_fast(arr)
#   max_subsum = arr.first
#   start_idx = 0
#
#   arr[1..-1].each.with_index(1) do |n,idx|
#
#
#     checking_subsum = max_subsum + n
#
#
#     if checking_subsum > max_subsum
#       max_subsum = checking_subsum
#     elsif checking_subsum < 0
#       next
#     end
#   end
# end

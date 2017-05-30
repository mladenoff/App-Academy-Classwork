require 'byebug'

class Array

  def my_each
    i = 0
    while i < self.length

      yield self[i]
      i += 1
    end
    self
  end

  def my_select
    storage = []
    self.my_each { |w| storage << w if yield(w) }
    storage
  end

  def my_reject
    storage = []
    self.my_each { |w| storage << w if !yield(w) }
    storage
  end

  def my_any?
    self.my_each { |w| return true if yield(w) }
    false
  end

  def my_all?
    self.my_each { |w| return false if !yield(w) }
    true
  end

end

# arr = [1,2,3]
# arr.my_each { |w| puts (w + 1) }

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

class Array



  def my_zip(*a)
    storage = Array.new(self.length){Array.new}
    i = 0
    while i < self.length
      self.my_each do |x|
        storage[i] << x
          a.my_each do |y|
            storage[i] << y[i]
          end
        i += 1
      end
    end
    storage
  end

  def my_rotate(num = 1)
    j = num % length
    self.drop(j) + self.take(j)
  end

  def my_join(sep = "")
    storage = ""
    i = 0
      self.my_each do |x|
        if i == 0
          storage << x
          i += 1
        else
          storage << sep
          storage << x
        end
      end
    storage
  end

  def my_reverse
    storage = []
    self.my_each { |x| storage.unshift(x) }
    storage
  end

  def my_flatten
    @@storage = []
    self.help_flatten
    @@storage
  end

  def help_flatten
    self.my_each do |x|
      if !(x.is_a?(Array))
        @@storage << x
      else
        x.help_flatten
      end
    end
  end

end

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8
# p [2,5].my_flatten

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]



# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
#
# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

def factors(num)
  storage = []
  (1..num).to_a.my_each do |x|
    if num % x == 0
      storage << x
    end
  end
  storage
end

# p factors(10)
# p factors(13)

class Array
  def bubble_sort!
    checked = true
    while checked
      checked = false
      self.each_with_index do |x,i|
        j = i + 1
        if j == self.length
          break
        elsif yield(x, self[j]) == 1
          self[j], self[i] = self[i], self[j]
          checked = true
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
  end
end

# p [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# p [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending

class Array
  def my_uniq
    new_arr = []
    self.each do |el|
      new_arr << el unless new_arr.include?(el)
    end
    new_arr
  end

  def two_sum
    res = []
    each_index do |i|
      each_index do |j|
        next if i >= j
        res << [i, j] if self[i] == self[j] * -1
      end
    end
    return nil if res.empty?
    res
  end

end

def my_transpose(arr)
  res = Array.new(arr.length) {Array.new}
  arr.each_with_index do |row, rowidx|
    row.each_with_index do |el, colidx|
      res[colidx][rowidx] = el
    end
  end
  res
end

def stock_picker(prices)
  days = []
  best_profit = 0
  prices.each_with_index do |price1, idx|
    prices.each_with_index do |price2, jdx|
      next if idx >= jdx
      if price2 - price1 > best_profit
        best_profit = price2 - price1
        days = [idx, jdx]
      end
    end
  end
  days
end

class TowersOfHanoi

  attr_accessor :towers

  def initialize
    @towers = [[3,2,1], [], []]
  end

  def play
    until won?
      puts "From which tower to which tower"
      user_input = gets.chomp
      move([user_input[0].to_i, user_input[-1].to_i])
    end
  end


  def move(arr)
    p towers
    if arr.any? { |el| !el.between?(0,2) }
      raise "Input valid tower"
    elsif towers[arr[0]].empty?
      raise "Can't move from empty tower"
    elsif towers[arr[0]].last > towers[arr[1]].last
      raise "Can't put big piece on small piece"
    else
      towers[arr[1]].push(towers[arr[0]].pop)
    end
  end

  def won?
    p towers
    return true if towers[1] == [3,2,1] || towers[2] == [3,2,1]
    false
  end

end

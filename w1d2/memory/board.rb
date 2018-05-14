require_relative "card"

class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(4) #{ Array.new }
  end

  # def self.default_grid
  #   Array.new(4) { Array.new(4) }
  # end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def populate
    card_values = (1..8).to_a + (1..8).to_a
    card_values.shuffle!
    int_to_card!(card_values)
    @grid.map! do |row|
      row = card_values.pop(4)
    end
    @grid

  end

  def int_to_card!(arr)
    arr.map! { |num| Card.new(num)}
  end

  def render
    @grid.each do |row|
      rendered_row = row.map do |card|
        unless card.face_status
          "X"
        else
          card.face_status
        end
      end
      p rendered_row
    end
  end

  def won?
    @grid.each do |row|
      row.each do |card|
        return false unless card.face_status
      end
    end
    true
  end

  def reveal(guessed_pos)
    unless self[guessed_pos].face_status
      self[guessed_pos].reveal
    end
    self[guessed_pos].face_value
  end

end

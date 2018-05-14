require_relative "tile"
require 'colorize'

class Board
  attr_reader :grid
  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file)
    arr = []
    File.foreach(file) do |line|
      arr << line.chomp.split("")
    end
    arr.map! do |row|
      row.map! do |box|
        unless box.to_i == 0
          box = Tile.new(box.to_i, true)
        else
          box = Tile.new(box.to_i, false)
        end
      end
    end
    Board.new(arr)
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos,val)
    row, col = pos
    @grid[row][col] = val
  end

  def render
    @grid.each do |row|
      rendered_row = row.map do |box|
        box.to_s
      end
      p rendered_row#.join(" ")
    end
  end

end

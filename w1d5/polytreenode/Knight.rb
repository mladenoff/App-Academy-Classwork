require_relative 'lib/00_tree_node'
require 'byebug'


class KnightPathFinder
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_pos = [start_pos]
    @move_tree = build_move_tree
  end

  def find_path(end_pos)
    node = @move_tree.bfs(end_pos)
    trace_path_back(node)
  end

  def trace_path_back(node)
    path = []
    until nodequi.nil?
      path << node.value
      node = node.parent
    end
    path
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    queue = [root]

    until queue.empty?
      node = queue.shift
      new_move_positions(node.value).each do |poss_pos|
        new_node = PolyTreeNode.new(poss_pos)
        new_node.parent = node
        queue << new_node

      end
    end
    root


  end

  def new_move_positions(pos)
    new_moves = []
    self.class.valid_moves(pos).each do |poss_pos|
      new_moves << poss_pos unless @visited_pos.include?(poss_pos)
    end
    @visited_pos += new_moves
    new_moves
  end

  def self.valid_moves(pos)
    x, y = pos
    pos_moves = []

    [x + 1, x - 1].each do |new_x|
      next unless new_x.between?(0, 7)
      [y + 2, y - 2].each do |new_y|
        next unless new_y.between?(0, 7)
        pos_moves << [new_x, new_y]
      end
    end

    [x + 2, x - 2].each do |new_x|
      next unless new_x.between?(0, 7)
      [y + 1, y - 1].each do |new_y|
        next unless new_y.between?(0, 7)
        pos_moves << [new_x, new_y]
      end
    end

    pos_moves
  end

end

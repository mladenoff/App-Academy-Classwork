require 'byebug'

class PolyTreeNode
  def initialize(value)
    @value = value
    @current_parent = nil
    @children = []
  end

  def parent
    @current_parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(new_parent)

    unless @current_parent == new_parent
      @current_parent.children.delete(self) if @current_parent
      @current_parent = new_parent #node's new_parent becomes current
      return unless new_parent
      new_parent.children << self # node is put into the new parent's children array
    end
  end

  def add_child(child_node)
    child_node.parent = self unless @children.include?(child_node)
  end

  def remove_child(child_node)
    raise unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end
  
  def bfs(target_value)
    queue = []
    queue.push(self)
    until queue.empty?
      shifted_node = queue.shift
      return shifted_node if shifted_node.value == target_value
      queue += shifted_node.children
    end
    nil
  end
end


# a = PolyTreeNode.new("a")
# b = PolyTreeNode.new("b")
# c = PolyTreeNode.new("c")
# d = PolyTreeNode.new("d")
# e = PolyTreeNode.new("e")
# f = PolyTreeNode.new("f")
# g = PolyTreeNode.new("g")
#
# b.parent = a
# c.parent = a
# d.parent = b
# e.parent = b
# f.parent = c
# g.parent = f

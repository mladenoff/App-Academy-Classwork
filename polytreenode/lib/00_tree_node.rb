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
      return child if child.value == target_value
      child.dfs(target_value)
    end
    nil
  end
end

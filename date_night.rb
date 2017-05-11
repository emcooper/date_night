require 'pry'

class Node
  attr_accessor :score, :title, :depth, :left, :right
  def initialize(score, title, depth = nil, left = nil, right = nil)
    @score = score
    @title = title
    @depth = depth
    @left = left
    @right = right
  end
end

class BinarySearchTree
  attr_accessor :root, :level, :current_node
  def initialize
    @root = nil
    @current_node = nil
  end
  def insert(score, title)
    @level = 0
    if root.nil?
      @root = Node.new(score, title, @level)
    else
      insert_recursively(score, title, @root)
    end
    @level
  end

  def insert_recursively(score, title, current_node)
    @level += 1
    if score < current_node.score
      if current_node.left.nil?
        create_child(score, title, current_node, "left")
      else
        insert_recursively(score, title, current_node.left)
      end
    elsif score > current_node.score
      if current_node.right.nil?
        create_child(score, title, current_node, "right")
      else
        insert_recursively(score, title, current_node.right)
      end
    end
  end

  def create_child(score, title, parent, direction)
    if direction == "left"
      parent.left = Node.new(score, title, @level)
    elsif direction == "right"
      parent.right = Node.new(score, title, @level)
    end
  end

  def include?(score)
    search(score, @root)
  end

  def search(score, current_node)
    @current_node = current_node
    @level += 1
    if score == current_node.score
      true
    elsif score < current_node.score
      if current_node.left.nil?
        false
      else
        search(score, current_node.left)
      end
    elsif score > current_node.score
      if current_node.right.nil?
        false
      else
        search(score, current_node.right)
      end
    end
  end

  def depth_of(score)
    @level = -1
    if search(score, @root)
      @level
    else
      nil
    end
  end

  def max
    search(100, @root)
    {@current_node.title => @current_node.score}
  end

  def min
    search(0, @root)
    {@current_node.title => @current_node.score}
  end

  def sort
    @sorted = []
    sort_recursive(@root)
    @sorted
  end

  def sort_recursive(current_node)
    index = 0
    inserted = false
    while inserted == false
      if @sorted[index] == nil || current_node.score < @sorted[index].values[0]
        @sorted.insert(index, {current_node.title => current_node.score})
        inserted = true
      end
      index += 1
    end
    if current_node.left != nil
      sort_recursive(current_node.left)
    end
    if current_node.right != nil
      sort_recursive(current_node.right)
    end
  end
end
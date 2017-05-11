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
  attr_accessor :root
  def initialize
    @root = nil
    @current_node = nil
    @sorted = []
    @level = 0
  end

  def insert(score, title, current_node = @root, level = 0)
    @level = level
    if @root.nil?
      @root = Node.new(score, title, @level)
      @root.depth
    else
      @level += 1
      if score < current_node.score
        if current_node.left.nil?
          create_child(score, title, current_node, "left").depth
        else
          insert(score, title, current_node.left, @level)
        end
      elsif score > current_node.score
        if current_node.right.nil?
          create_child(score, title, current_node, "right").depth
        else
          insert(score, title, current_node.right, @level)
        end
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
    search(score, @root) != nil
  end

  def search(score, current_node)
    @current_node = current_node
    @level += 1
    if score == current_node.score
      current_node
    elsif score < current_node.score
       if current_node.left != nil
        search(score, current_node.left)
      end
    elsif score > current_node.score
      if current_node.right != nil
        search(score, current_node.right)
      end
    end
  end

  def depth_of(score)
    if search(score, @root) != nil
      search(score, @root).depth
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

  def sort(current_node = @root)
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
      sort(current_node.left)
    end
    if current_node.right != nil
      sort(current_node.right)
    end
    @sorted
  end
  def load(file)

  end 
end

class Tree
  def initialize(array)
    @values = array
    build_tree
  end

  attr_accessor :values, :root

  def build_tree
    @root = Node.new(values.pop)
    values.each { |value| insert(Node.new(value)) }
    root
  end

  def insert(new_node, current_node = root)
    new_node = Node.new(new_node) unless new_node.instance_of?(Node)

    if new_node > current_node
      if current_node.right_node.nil?
        current_node.right_node = new_node
      else
        insert(new_node, current_node.right_node)
      end
    else
      if current_node.left_node.nil?
        current_node.left_node = new_node
      else
        insert(new_node, current_node.left_node)
      end
    end
    self
  end

  def delete(value, previous_node = root, current_node = root)
    value = value.value if value.instance_of?(Node)

    if value == root.value
      self.values = to_a
      self.values.delete(value)
      build_tree
    elsif value > current_node.value
      if current_node.value == value
        previous_node.right_node = current_node.right_node
        current_node.right_node = nil
      else
        delete(value, current_node, current_node.right_node)
      end
    else
      if current_node.value == value
        if previous_node.value < value
          previous_node.right_node = current_node.left_node
        else
          previous_node.left_node = current_node.left_node
        end

        current_node.left_node = nil
      else
        delete(value, current_node, current_node.left_node)
      end
    end
    self
  end

  def find(value, current_node = root)
    if value > current_node.value
      if value == current_node.value
        current_node
      else
        find(value, current_node.right_node)
      end
    else
      if value == current_node.value
        current_node
      else
        find(value, current_node.left_node)
      end
    end
  end

  def to_a(current_node = root, array = [])
    to_a(current_node.left_node, array) if current_node.left_node
    array << current_node.value
    to_a(current_node.right_node, array) if current_node.right_node
    array
  end
end


class Node
  def initialize(value)
    @value = value
    @left_node = nil
    @right_node = nil
  end

  include Comparable

  attr_accessor :value, :left_node, :right_node

  def <=>(other)
    value <=> other.value
  end
end

# p tree = Tree.new([2, 2, 4, 4, 1, 1, 6, 6])
# p tree.to_a
# p tree.delete(4)
# p tree.to_a

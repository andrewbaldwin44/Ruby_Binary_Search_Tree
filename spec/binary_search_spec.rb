require_relative '../lib/binary_search_tree'

describe Node do
  describe "creating nodes" do
    it "can hold a value" do
      node = Node.new(5)
      expect(node.value).to eql(5)
    end

    it "can hold a right and left node" do
      node = Node.new(27)
      left = Node.new([1, 2, 3, 4, 5])
      right = Node.new("hello")
      node.left_node = left
      node.right_node = right
      expect(node.value).to eql(27)
      expect(node.left_node.value).to eql([1, 2, 3, 4, 5])
      expect(node.right_node.value).to eql("hello")
    end

    it "can compare nodes using the Comparable module" do
      node1 = Node.new(44)
      node2 = Node.new(5)
      expect(node1 < node2).to be false
      expect(node1 > node2).to be true
      expect(node1 == node2).to be false
      expect(node1 <=> node2).to eql(1)
    end
  end
end

describe Tree do
  describe "build tree" do
    it "builds a simple balanced tree" do
      tree = Tree.new([5, 3, 4, 2, 1])
      expect(tree.to_a).to eql([1, 2, 3, 4, 5])
    end

    it "builds a longer balanced tree" do
      tree = Tree.new([1, 23, 8, 9, 4, 3, 5, 7, 67, 6345, 324])
      expect(tree.to_a).to eql([1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345])
    end

    it "can handle duplicates" do
      tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
      expect(tree.to_a).to eql([1, 3, 4, 4, 5, 7, 7, 8, 9, 9, 23, 67, 324, 6345])
    end

    it "can handle strings" do
      tree = Tree.new(%w[zebras bucket phone plates cups bags socks])
      expect(tree.to_a).to eql(["bags", "bucket", "cups", "phone", "plates", "socks", "zebras"])
    end

    it "can handle sub-arrays" do
      tree = Tree.new([[44, 66, 77], [1, 2, 3], [3, 2, 1], [-1, 2, 1, 1]])
      expect(tree.to_a).to eql([[-1, 2, 1, 1], [1, 2, 3], [3, 2, 1], [44, 66, 77]])
    end
  end

  describe "adding and removing from tree" do
    it "can insert a value into tree" do
      tree = Tree.new([7, 6, 44, 28, 3])
      tree.insert(29)
      expect(tree.to_a).to eql([3, 6, 7, 28, 29, 44])
    end

    it "can insert multiple values into tree" do
      tree = Tree.new([12, 15, 3, 4, 98, 7])
      tree.insert(5).insert(12).insert(-506).insert(4444)
      expect(tree.to_a).to eql([-506, 3, 4, 5, 7, 12, 12, 15, 98, 4444])
    end

    it "can delete a value from tree" do
      tree = Tree.new([10, 9, 8, 7, 3, 2, 15])
      tree.delete(7)
      expect(tree.to_a).to eql([2, 3, 8, 9, 10, 15])
    end

    it "can delete the first value from tree" do
      tree = Tree.new([10, 8, 6, 4, 2])
      tree.delete(2)
      expect(tree.to_a).to eql([4, 6, 8, 10])
    end

    it "can delete the last value from tree" do
      tree = Tree.new([50, 60, 70, 3, 40, 30, 12])
      tree.delete(70)
      expect(tree.to_a).to eql([3, 12, 30, 40, 50, 60])
    end

    it "can delete a negative value from tree" do
      tree = Tree.new([12, -12, 30, -30, -4, 7, -904, 56])
      tree.delete(-30)
      expect(tree.to_a).to eql([-904, -12, -4, 7, 12, 30, 56])
    end

    it "can delete a duplicated value from tree" do
      skip
      tree = Tree.new([2, 2, 4, 4, 1, 1, 6, 6])
      tree.delete(4)
      expect(tree.to_a).to eql([1, 1, 2, 2, 4, 6, 6])
    end

    it "can delete multiple values from tree" do
      tree = Tree.new([7, 6, 5, 4, 3, 2, 1])
      tree.delete(7).delete(4)
      expect(tree.to_a).to eql([1, 2, 3, 5, 6])
    end
  end

  describe 'traversing the tree' do
    it "can find a value in the tree" do
      tree = Tree.new([1, 100, 1000, 10000, 100000, 1000000])
      expect(tree.find(100).value).to eql(100)
    end
  end
end

require_relative './BinarySearchTree/Binary_search_tree'
require_relative './LinkedList/linked_list'

# This method will take in a binary search tree and convert it to a Double Linked List
def convert_to_linked_list(tree)
  linked_list = LinkedList.new
  stack = [tree]
  temp = nil

  until stack.empty?
    until stack[-1].left == nil
      stack << stack[-1].left
    end
    temp = stack.pop
    unless stack.empty?
      temp = stack.pop
    end
    stack << temp.right unless temp.right == nil
  end

  nil
end

example_bst = BST.new(8,
                BST.new(3,
                   BST.new(1),
                   BST.new(6,
                       BST.new(4),
                       BST.new(7))),
               BST.new(10,
                   nil,
                   BST.new(14,
                       BST.new(13),
                       nil)))

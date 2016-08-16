require_relative './BinarySearchTree/Binary_search_tree'
require_relative './LinkedList/linked_list'

# This method will take in a binary search tree and convert it to a Double Linked List
def convert_to_linked_list(tree)
  linked_list = LinkedList.new
  stack = [tree]
  temp = nil

  loop do
    until stack[-1].left == nil
      stack << stack[-1].left
    end
    stack.pop
    temp = stack.pop
    stack << temp.right unless temp.right == nil
  end
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

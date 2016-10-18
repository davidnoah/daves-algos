# Visual Display of Example: https://upload.wikimedia.org/wikipedia/commons/d/da/Binary_search_tree.svg

class BST
  attr_accessor :data, :left, :right

  def initialize(data, left=nil, right=nil)
    @data = data
    @left = left
    @right = right
  end

  def to_s
    if @left.nil? and @right.nil?
      @data.to_s
    else
      left_str = @left.nil? ? :_ : @left.to_s
      right_str = @right.nil? ? :_ : @right.to_s
      "(#{left_str} #{@data.to_s} #{right_str})"
    end
  end

  def nth_smallest(x)
    stack = [self]
    counter = 0
    temp = nil

    until stack.empty?
      until stack[-1].left == nil
        stack << stack[-1].left
      end
      if stack[-1].right == nil
        temp = stack.pop
        counter += 1
        return temp.data if counter == x

        unless stack.empty?
          temp = stack.pop
          counter += 1
          return temp.data if counter == x
        end

        stack << temp.right unless temp.right == nil
      else
        temp = stack.pop
        counter += 1
        return temp.data if counter == x

        stack << temp.right
      end
    end

    nil
  end

  # In-order traversal
  def stack_max_size
    serialized_arr = []
    stack = [self]
    stack_size = 1

    until stack.empty?
      until stack[-1].left == nil
        stack << stack[-1].left
      end
      stack_size = stack.length if stack_size < stack.length

      if stack[-1].right == nil
        temp = stack.pop
        serialized_arr << temp.data

        unless stack.empty?
          temp = stack.pop
          serialized_arr << temp.data
        end

        stack << temp.right unless temp.right == nil
        stack_size = stack.length if stack_size < stack.length
      else
        temp = stack.pop
        serialized_arr << temp.data

        stack << temp.right
        stack_size = stack.length if stack_size < stack.length
      end
    end

    stack_size
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
def nth_smallest_recur(root, x)
  return nil if root == nil

  nth_smallest_recur(root.left, x)
  x -= 1
  return root.data if x == 0
  nth_smallest_recur(root.right, x)
end

p nth_smallest_recur(example_bst, 4)



def serialize_binary_tree(root, arr)
  return arr << nil if root == nil

  arr << root.data
  serialize_binary_tree(root.left, arr)
  serialize_binary_tree(root.right, arr)
end
$i = 0

def deserialize_binary_tree(arr)
  return nil if arr == nil || arr.length == 0
  return nil if $i >= arr.length || arr[$i] == nil

  root = BST.new(arr[$i])
  $i += 1
  root.left = deserialize_binary_tree(arr)
  $i += 1
  root.right = deserialize_binary_tree(arr)
  root
end

def create_minimal_height_tree(arr)
  return nil if arr.length == 0
  return BST.new(arr[0]) if arr.length == 1

  mid_index = (arr.length / 2)

  root = BST.new(arr[mid_index])
  root.left = create_minimal_height_tree(arr[0...mid_index])
  root.right = create_minimal_height_tree(arr[(mid_index + 1)..(arr.length - 1)])
  return root
end

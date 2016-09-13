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

  def serialize
    serialized_arr = []
    stack = [self]

    until stack.empty?
      until stack[-1].left == nil
        stack << stack[-1].left
      end

      if stack[-1].right == nil
        temp = stack.pop
        serialized_arr << temp.data

        unless stack.empty?
          temp = stack.pop
          serialized_arr << temp.data
        end

        stack << temp.right unless temp.right == nil
      else
        temp = stack.pop
        serialized_arr << temp.data

        stack << temp.right
      end
    end

    serialized_arr
  end
end

example_bst = BST.new(8,
                BST.new(3,
                   BST.new(1, nil, BST.new(2)),
                   BST.new(6,
                       BST.new(4),
                       BST.new(7))),
               BST.new(10,
                   nil,
                   BST.new(14,
                       BST.new(13),
                       nil)))
p example_bst.nth_smallest(2)
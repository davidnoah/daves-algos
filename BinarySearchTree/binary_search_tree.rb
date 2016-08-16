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

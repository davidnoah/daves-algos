class Graph
  attr_accessor :data, :children

  def initialize(data, children=nil)
    @data = data
    @left = left
    @right = right
  end

end

def find_target_BFS(node, target)
  queue = [node]
  depth = 0
  loop do
    current_node = queue.pop

    return nil if current_node.nil?
    return depth if current_node == target

end

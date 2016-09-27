require 'set'

class Graph
  attr_accessor :data, :children

  def initialize(data, children=nil)
    @data = data
    @children = children
  end
end

example_graph = Graph.new("Kevin", [Graph.new("Chuckie", [Graph.new("Randy"), Graph.new("Jose")]), Graph.new("Billy", []), Graph.new("Sandra", [Graph.new("Kelly")])])

def find_target_BFS(node, target)
  queue = [node]
  last_child = node
  depth = 0

  loop do
    current_node = queue.pop

    return nil if current_node.nil?
    return depth if current_node.data == target

    queue = current_node.children + queue unless current_node.children == nil
    if current_node == last_child
      depth += 1
      last_child = queue[0]
    end
  end
end

def frog_lily(x, arr)
  set = Set.new
  arr.length.times do |i|
    if arr[i] <= x
      set.add(arr[i])
    end
    return i if set.length == x
  end
  return nil
end

def min_depth(node)
  queue = [node]
  depth = 0
  last_child = node

  loop do
    temp = queue.shift
    return depth if temp.children.empty?
    queue = queue + temp.children
    if temp == last_child
      depth += 1
      last_child = queue[-1]
    end
  end
end

p min_depth(example_graph)

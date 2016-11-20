require 'set'

class Graph
  attr_accessor :data, :children, :color

  def initialize(data, children=nil)
    @data = data
    @children = children
    @color = nil
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


def find_max_stored_BFS(node)
  queue = [node]
  current_max = 1

  until queue.empty?
    current_node = queue.pop
    queue = current_node.children + queue unless current_node.children == nil
    if current_max < queue.length
      current_max = queue.length
    end
  end
  current_max
end

def find_max_stored_DFS(node)
  stack = [node]
  current_max = 1

  until stack.empty?
    current_node = stack.pop
    stack = stack + current_node.children unless current_node.children == nil
    p stack
    if current_max < stack.length
      current_max = stack.length
    end
  end
  current_max
end

graph = Graph.new("A")
graph.children = [Graph.new("C"), Graph.new("E")]
graph.children[0].children = [graph, Graph.new("B"), Graph.new("D")]
graph.children[1].children = [graph, graph.children[0].children[1], graph.children[0].children[2]]
graph.children[0].children[1].children = [graph.children[0], graph.children[0].children[2], graph.children[1]]
graph.children[0].children[2].children = [graph.children[0], graph.children[0].children[1], graph.children[1]]

a = Graph.new("A")
b = Graph.new("B")
c = Graph.new("C")
d = Graph.new("D")
a.children = [b,d,c]
b.children = [a,c,d]
c.children = [b,d,a]
d.children = [a,c,b]


def color_graph(root, num_colors)
  colors_array = (1..num_colors).to_a
  root.color = colors_array[0]
  seen = {root => root.color}
  queue = [root]

  until queue.empty?
    current_node = queue.shift
    current_node.children.each do |child|
      unless seen[child]
        used_colors = child.children.map {|child| child.color if child.color}
        usuable_colors = colors_array.reject {|color| used_colors.include?(color)}
        child.color = usuable_colors[0]
        queue << child
        seen[child] = child.color
      end
    end
  end

  seen.each do |child,color|
    p "#{child.data}: #{color}"
  end

end

p color_graph(a, 3)

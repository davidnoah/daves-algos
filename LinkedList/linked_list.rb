class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :tail, :head

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
   end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each {|node| return node.val if key == node.key}
    nil
  end

  def include?(key)
    each {|node| return true if key == node.key}
    false
  end

  def insert(key, val)
    each {|node| return node.val = val if node.key == key}

    new_link = Link.new(key, val)

    @tail.prev.next = new_link
    new_link.prev = @tail.prev
    new_link.next = @tail
    @tail.prev = new_link

    new_link
  end

  def remove(key)
      each do |node|
        if node.key == key
          node.prev.next = node.next
          node.next.prev = node.prev
          return node.val
        end
      end
      nil
  end

  def each
    current_node = @head.next
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

def create_single_list(n)
  list = Link.new(0, 0)
  temp = list
  (n - 1).times do |i|
    temp.next = Link.new(i + 1, i + 1)
    temp = temp.next
  end

  list
end



def nth_last_element(n, link)
  p1 = link
  p2 = link
  counter = 0
  until counter == n
    p2 = p2.next
    counter += 1
  end

  until p2.next == nil
    p1 = p1.next
    p2 = p2.next
  end

  p1
end

list = create_single_list(8)
p nth_last_element(7, list)

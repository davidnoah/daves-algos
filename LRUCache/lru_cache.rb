require_relative '../HashMap/hash_map'
require_relative '../LinkedList/linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      update_link!(@map[key])
      @map[key].val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    value = @prc.call(key)
    new_link = @store.insert(key, value)
    @map[key] = new_link

    eject! if @max < count
    value
  end

  def update_link!(link)
    link.prev.next = link.next
    link.next.prev = link.prev

    link.prev = @store.last
    link.next = @store.tail
    @store.last.next = link
  end

  def eject!
    ejected_link = @store.first
    ejected_link.prev.next = ejected_link.next
    ejected_link.next.prev = @store.head

    @map.delete(ejected_link.key)
    nil
  end
end

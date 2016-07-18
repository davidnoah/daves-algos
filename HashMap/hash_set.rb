require_relative 'hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    key = key.hash
    @store[key % num_buckets] << key
    @count += 1
    resize! if @count > num_buckets
    key
  end

  def remove(key)
    key = key.hash
    @store[key % num_buckets].delete(key)
  end

  def include?(key)
    key = key.hash
    @store[key % num_buckets].include?(key)
  end

  private

  def [](key)
    key = key.hash
    @store[key % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0

    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.flatten.each {|hash| insert(hash)}
  end
end

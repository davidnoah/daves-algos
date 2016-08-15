class BinaryMinHeap
  def initialize(&prc)
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    child_indices = []
    child_indices << ((2*parent_index) - 1) if ((2*parent_index) - 1) < len
    child_indices << ((2*parent_index) - 2) if ((2*parent_index) - 2) < len
    child_indices
  end

  def self.parent_index(child_index)
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end

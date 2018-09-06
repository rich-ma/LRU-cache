require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    bucket = bucket(key)
    if @store[bucket].include?(key)
      @store[bucket].update(key, val)
    else
      resize! if count == num_buckets
      @store[bucket].append(key, val)
      @count += 1
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
      @store[bucket(key)].remove(key)
      @count -= 1

  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2){ LinkedList.new }
    @store.each do |bucket|
      bucket.each do |node|
        idx = bucket(node.key, num_buckets * 2)
        new_store[idx].append(node.key, node.val)
      end
    end
    @store = new_store
  end

  def bucket(key, buckets = num_buckets)
    key.hash % buckets
  end
end

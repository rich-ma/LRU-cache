require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    unless self[key].include?(key)
      self[key] << key
      @count += 1
    end
  end
  
  def include?(key)
    self[key].include?(key)
  end
  
  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](key)
    bucket = key.hash % num_buckets
    @store[bucket]
  end

  def num_buckets
    @store.length
  end

   def resize!
    new_store = Array.new(num_buckets * 2){ Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        new_bucket = num % new_store.length
        new_store[new_bucket] << num
      end
    end
    @store = new_store
  end
end

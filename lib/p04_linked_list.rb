class Node
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

  def remove
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  attr_reader :head, :tail
  include Enumerable
  
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
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
    each {|node| return node.val if node.key == key}
    nil
  end

  def include?(key)
    each {|node| return true if node.key == key}
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    prev_last = @tail.prev
    prev_last.next = new_node
    new_node.prev = prev_last
    new_node.next = @tail
    @tail.prev = new_node
    new_node
  end

  def update(key, val)
    each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    each {|node| node.remove if node.key == key}
  end

  def each(&prc)
    prc ||= proc{|node| node }
    curr_node = @head.next
    until curr_node.next.nil?
      prc.call(curr_node)
      curr_node = curr_node.next
    end
  end

  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end

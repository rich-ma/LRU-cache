class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    array_hash = self.each_with_index.map do |el, idx|
      (el * (idx + 1)).hash
    end
    array_hash.reduce(:+).hash
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.map do |el|
      (el[0].to_s.ord.hash + el[1].to_s.ord.hash).hash
    end.hash
  end
end

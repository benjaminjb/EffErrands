class BranchBound
  def initialize(raw_matrix)
    @home = raw_matrix[0].keys[0]
    @matrix = []
    @included = {}
    @excluded = {}
    build_matrix(raw_matrix)
  end

  def build_matrix(raw_matrix)
    raw_matrix.each do |origin|
      holding_hash = {}
      key = origin.keys[0]
      origin.values.flatten(1).each do |dest|
        name = "#{key}--#{dest[0]}" #.downcase
        holding_hash[name] = dest[1]
      end
      @matrix << holding_hash
    end
  end

  def build_tree()
    infinitize
    while @included.length < @matrix.length
      @matrix.each do |row|
        row.each do |key,value|
          node_vs_node(included: @included, excluded: @excluded, path: {key => value})
        end
      end
    end
    build_result
  end

  def node_vs_node(included: included, excluded: excluded, path: path)
    # path must be hash, with key of path name, value of distance
    least_edges_all_with = least_edges_all(included: included.merge(path), excluded: excluded)[0].flatten.map(&:to_s).inject(:+)
    least_edges_all_without = least_edges_all(included: included, excluded: excluded.merge(path))[0].flatten.map(&:to_s).inject(:+)

    # binding.pry
    if least_edges_all_with > least_edges_all_without
      @included = @included.merge(path)
    else
      @excluded = @excluded.merge(path)
    end
  end

  def least_edges_all(included: {}, excluded: {})
    # included and excluded will be hashes; the hash is trip-name:=>distance, empty hashes cool
    least_all = []
    # binding.pry
    @matrix.each do |hash|
      binding.pry
      least_all << least_edges(included: included, excluded: excluded, hash: hash)
    end
    # binding.pry
    return least_all
    # an array of hashes from each level of the matrix
  end


  def least_edges(included: {}, excluded: {}, hash: hash)
    # included and excluded will be hashes; the hash is trip-name:=>distance, empty hashes cool
    keeper_array = included.keys & hash.keys
    least = included.keep_if {|k,_| keeper_array.include?(k) }
    hashwork = hash
    step1 = hashwork.delete_if {|key, value| excluded.has_key?(key) }.delete_if {|k,_| least.has_key?(k)}
    step2 = step1.sort_by {|_,v| v}
    i = 0
    until (least.length > 1)
      if (step2[i].nil?)
        least["fail"+i.to_s] = Float::INFINITY
        i += 1
      else
        least[step2[i][0]] = step2[i][1]
        i += 1
      end
    end
    return least
    # will return a hash of the 2 lowest distances, minus any excluded
  end

  def build_result
    solution_array = []
    home_holder = @included.keep_if {|k,v| k.include?(@home) }
    other_holder = @included.keep_if {|k,v| !k.include?(@home) }
    holder = home.pop
    find = holder.keys.split('--')[1]
    solution_array << holder
    until @included.length == 0
      holder = @included.delete_if {|k,v| k.include?(find) }
      find = holder.keys.split('--')[1]
      solution_array << holder
    end
    solution_array << home.pop
    solution_array = test.map(&:to_a).flatten(1)
    solution = {}
    solution_array.each_index do |index|
      solution[index] = solution_array[index]
    end
    return solution
  end

  def infinitize()
    # a method for removing any key with a distance of zero
    @matrix.each do |hash|
      hash.each do |k,v| 
        hash.delete(k) if v == 0
      end
    end      
  end

end
module BranchBoundTSP
  def self.solver=(x)
    @solver = x
  end

  def self.solver
    @solver
  end
end

BranchBoundTSP.solver = BranchBoundTSP::Solver.new

module BranchBoundTSP
  class Solver
    attr_accessor :matrix, :nodelist, :optimal_path
    
    def initialize(matrix)
      @matrix = matrix
      @included = {}
      @excluded = {}
    end

    def build_tree()
      infinitize
      
      while @optimal_path.length < matrix.length

        # check each 
          node_vs_node(included: @included, excluded: @excluded, path: path)
        end
      end



    end

    def node_vs_node(included: included, excluded: excluded, path: path)
      # path must be hash, with key of path name, value of distance

      least_edges_all_with = least_edges_all(included: included.merge(path), excluded: excluded).map {|x| x.values }.flatten.inject(:+)
      least_edges_all_without = least_edges_all(included: included, excluded: excluded.merge(path)).map {|x| x.values }.flatten.inject(:+)

      if least_edges_all_with > least_edges_all_without
        @included[path.keys[0]] = path.values[0]
        return true
      else
        @excluded[path.keys[0]] = path.values[0]
        return false
      end
    end

    def infinitize()
      # a method for making 0 distances into infinity (so they don't get picked up as lowest distances)
      # @matrix.each do |array|
      #   hash.each do |k,_| 
      #     hash[k] = Float::INFINITY if hash[k]==0
      #   end
      # end

      # a method for removing any key with a distance of zero
      @matrix.each do |array|
        hash.each do |k,v| 
          hash.delete(k) if v == 0
        end
      end      
    end

    def least_edges(included: {}, excluded: {}, hash: hash)
      # included and excluded will be hashes; the hash is trip-name:=>distance, empty hashes cool
      least = included
      hashwork = hash
      copy = hashwork.delete_if {|key, value| excluded.has_key?(key) }.sort_by {|_,v| v}
      i = 0
      until (least.length == 2)
        least[copy[i][0]] = copy[i][1]
        i += 1
      end
      return least
      # will return a hash of the 2 lowest distances, minus any excluded
    end

    def least_edges_all(included: nil, excluded: nil)
      # included and excluded will be hashes; the hash is trip-name:=>distance, empty hashes cool
      least_all = []
      @matrix.each do |hash|
        least_all << least_edges(included: included, excluded: excluded, hash: hash)
      end
      return least_all
      # an array of hashes from each level of the matrix
    end




  end
end





module BranchBoundTSP
  class BBNode
    attr_accessor :least, :parent, :left_child, :right_child 
    def initialize(name: name, least: nil, parent: nil, left_child: nil, right_child: nil)
      @name = name
      @least = least
      @parent = parent
      @left_child = left_child
      @right_child = right_child
      BranchBoundTSP.solver.nodelist << self
    end
  end
end
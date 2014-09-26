require_relative 'spec_helper.rb'

describe BranchBound do

  it "runs the program" do
    test = [
      {"A"=>
        [
        ["B", 10], 
        ["C", 100], 
        ["D", 1000],
        ["E", 10000],
        ["A", 0]]}, 
      {"B"=>
        [
        ["B", 0], 
        ["C", 20], 
        ["D", 200],
        ["E", 2000],
        ["A", 10]]}, 
      {"C"=>
        [
        ["B", 20], 
        ["C", 0], 
        ["D", 30],
        ["E", 300],
        ["A", 100]]},
      {"D"=>
        [
        ["B", 200], 
        ["C", 30], 
        ["D", 0],
        ["E", 40],
        ["A", 10000]]},
      {"E"=>
        [
        ["B", 2000], 
        ["C", 300], 
        ["D", 40],
        ["E", 0],
        ["A", 10000]]}
      ]    


      # {"1803 East 18th Street, Austin, TX 78702, USA"=>
      #   [
      #   ["2300 West Ben White Boulevard, Austin, TX 78704, USA", 12863], 
      #   ["1000 East 41st Street, Hancock Shopping Center, Austin, TX 78751, USA", 2738], 
      #   ["800 Brazos Street, Austin, TX 78701, USA", 3020],
      #   ["1803 East 18th Street, Austin, TX 78702, USA", 0]]}, 
      # {"2300 West Ben White Boulevard, Austin, TX 78704, USA"=>
      #   [
      #   ["2300 West Ben White Boulevard, Austin, TX 78704, USA", 0], 
      #   ["1000 East 41st Street, Hancock Shopping Center, Austin, TX 78751, USA", 14830], 
      #   ["800 Brazos Street, Austin, TX 78701, USA", 11577],
      #   ["1803 East 18th Street, Austin, TX 78702, USA", 10000]]}, 
      # {"1000 East 41st Street, Hancock Shopping Center, Austin, TX 78751, USA"=>
      #   [
      #   ["2300 West Ben White Boulevard, Austin, TX 78704, USA", 14498], 
      #   ["1000 East 41st Street, Hancock Shopping Center, Austin, TX 78751, USA", 0], 
      #   ["800 Brazos Street, Austin, TX 78701, USA", 4668],
      #   ["1803 East 18th Street, Austin, TX 78702, USA", 50000]]}]

    tester = BranchBound.new(test)
    mytestanswer = tester.build_tree()
  end
end

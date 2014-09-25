require_relative 'spec_helper.rb'

describe BranchBound do

  it "runs the program" do
    test = [
      {"1803 East 18th Street, Austin, TX 78702, USA"=>
        [
        ["2300 West Ben White Boulevard, Austin, TX 78704, USA", 12863], 
        ["1000 East 41st Street, Hancock Shopping Center, Austin, TX 78751, USA", 2738], 
        ["800 Brazos Street, Austin, TX 78701, USA", 3020],
        ["1803 East 18th Street, Austin, TX 78702, USA", 0]]}, 
      {"2300 West Ben White Boulevard, Austin, TX 78704, USA"=>
        [
        ["2300 West Ben White Boulevard, Austin, TX 78704, USA", 0], 
        ["1000 East 41st Street, Hancock Shopping Center, Austin, TX 78751, USA", 14830], 
        ["800 Brazos Street, Austin, TX 78701, USA", 11577],
        ["1803 East 18th Street, Austin, TX 78702, USA", 10000]]}, 
      {"1000 East 41st Street, Hancock Shopping Center, Austin, TX 78751, USA"=>
        [
        ["2300 West Ben White Boulevard, Austin, TX 78704, USA", 14498], 
        ["1000 East 41st Street, Hancock Shopping Center, Austin, TX 78751, USA", 0], 
        ["800 Brazos Street, Austin, TX 78701, USA", 4668],
        ["1803 East 18th Street, Austin, TX 78702, USA", 50000]]}]

    tester = BranchBound.new(test)
    mytestanswer = tester.build_tree()
  end
end

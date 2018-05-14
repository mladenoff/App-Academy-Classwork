class HumanPlayer
  def initialize(name)
    @name = name
  end

  def prompt
    puts "Guess a position: "
    guess = gets.chomp
    guess = guess.split(",")
    [guess[0].to_i, guess[-1].to_i]
  end

  def hash_maker(a,b)
  end


end

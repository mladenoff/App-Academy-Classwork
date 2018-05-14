class AIPlayer
  def initialize(name)
    @name = name
    @known_cards = {}
  end

  def prompt
    guess = []
    if false

    else
      while @known_cards.key?(guess)
        guess[0] = (0..3).to_a.sample
        guess[1] = (0..3).to_a.sample
      end
    end
    guess
  end

 def hash_maker(key,val)
   @known_cards[key] = val
 end


end

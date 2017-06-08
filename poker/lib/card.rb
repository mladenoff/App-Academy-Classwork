class Card
  attr_reader :suit, :value

  VALUES_HASH = {
    11 => "Jack",
    12 => "Queen",
    13 => "King",
    14 => "Ace"
  }

  def initialize(suit, value)
    @suit, @value = suit, value
  end

  SUIT_HASH = {
    clubs: 1,
    diamonds: 2,
    hearts: 3,
    spades: 4
  }

  def suit_val
    SUIT_HASH[suit]
  end

  def to_s
    "#{value > 10 ? VALUES_HASH[value] : value} of #{suit}"
  end

end

require_relative 'card'
class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    reset
  end

  def reset
    suits = [:clubs, :diamonds, :hearts, :spades]
    (0..3).each do |suit|
      (2..14).each do |val|
        cards << Card.new(suits[suit], val)
      end
    end
  end

  def deal_cards(n)
    raise "Too many cards" if n > 5
    cards.shuffle!
    res = []
    n.times { res << cards.pop }
    res
  end
end

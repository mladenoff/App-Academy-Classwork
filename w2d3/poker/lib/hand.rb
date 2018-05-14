require_relative 'card'

class Hand

  HAND_RANKING = {

  }

  attr_accessor :cards

  def initialize
    @cards = []
  end
  #an array of cards
  #determine hand rank
    #iterate through hash best to worst
  #rank of hand hash

  def evaluate_hand
    rank = []
    rank << ranking
    rank + high_card_val_and_suit
  end


  def high_card_val_and_suit
    high_card = cards.sort_by(&:value).last
    highest_cards = cards.select { |card| card.value == high_card.value }
    high_card = highest_cards.sort_by { |card| card.suit_val }.last
    [high_card.value, high_card.suit_val]
  end

  def ranking
    card_values = cards.map { |card| card.value }
    card_suits = cards.map { |card| card.suit }
    val_len = card_values.uniq.length
    suit_len = card_suits.uniq.length

    if suit_len == 1 #flush
      if card_values.max - card_values.min == 4 #straight flush
        9
      else #regular flulsh
        6
      end
    elsif val_len == 2
      case card_values.count(card_values.first)
      when 1, 4 #4 of a kind
        8
      else #full house
        7
      end
    elsif val_len == 3 #two pair of 3 of a kind
      return 4 if card_values.any? {|val| card_values.count(val) == 3}
      return 3 #otherwise is two pair
    elsif val_len == 4
      2
    elsif card_values.max - card_values.min == 4 #straight
      5
    else #high card
      1
    end
  end

end

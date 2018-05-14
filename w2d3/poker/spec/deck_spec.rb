require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "initializes with a full deck" do
      expect(deck.cards.length).to be(52)
    end

    it "initializes with a unique deck" do

      expect(deck.cards.uniq.length).to be(52)
    end
  end

  describe "#deal_cards" do
    it "raises error if asked for too many cards" do
      expect{deck.deal_cards(6)}.to raise_error("Too many cards")
    end

    it "deals correct number of cards" do
      expect(deck.deal_cards(3).length).to eq(3)
    end

    it "should decrement the deck's number of cards" do
      deck.deal_cards(4)
      expect(deck.cards.length).to eq(48)
    end
  end

  describe "#reset" do
    it "resets to a full deck" do
      deck.cards = []
      deck.reset
      expect(deck.cards.length).to eq(52)
    end

  end
end

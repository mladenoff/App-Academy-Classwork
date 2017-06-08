require 'rspec'
require 'hand'

describe Hand do
  subject(:hand) { Hand.new }
  let(:cards) {[
               Card.new(:spades, 10),
               Card.new(:hearts, 10),
               Card.new(:hearts, 10),
               Card.new(:diamonds, 2),
               Card.new(:hearts, 2)
             ]}
    describe "#initialize" do
      it "initializes with an empty array of cards" do
        expect(hand.cards).to eq([])
      end
    end

    describe "#evaluate_hand" do
      it "properly evaluates a full house" do
        hand.cards = cards
        expect(hand.evaluate_hand).to eq([7,10,4])

      end

      it "properly evaluates two pair" do
        hand.cards = [Card.new(:spades,2),
          Card.new(:hearts,2),
          Card.new(:clubs,5),
          Card.new(:spades,3),
          Card.new(:hearts,3)]
        expect(hand.evaluate_hand).to eq([3,5,1])
      end

      it "properly evaluates three of a kind" do
        hand.cards = [Card.new(:spades,2),
          Card.new(:hearts,2),
          Card.new(:clubs,2),
          Card.new(:spades,5),
          Card.new(:hearts,3)]
        expect(hand.evaluate_hand).to eq([4,5,4])
      end

      it "properly evaluates a pair" do
        hand.cards = [Card.new(:spades,8),
          Card.new(:hearts,2),
          Card.new(:clubs,2),
          Card.new(:spades,5),
          Card.new(:hearts,3)]
        expect(hand.evaluate_hand).to eq([2,8,4])
      end

      it "properly evaluates a worthless hand" do
        hand.cards = [Card.new(:hearts,11),
          Card.new(:hearts,7),
          Card.new(:clubs,2),
          Card.new(:spades,5),
          Card.new(:hearts,3)]
        expect(hand.evaluate_hand).to eq([1,11,3])

      end
    end
end

require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:clubs, 5)}
  # @to_s = "#{value} of #{suit}"

  describe "#initalize" do
    it "initalizes with the proper value" do
      expect(card.value).to eq(5)
    end
    it "initalizes with the proper suit" do
      expect(card.suit).to eq(:clubs)
    end
  end

  describe "#to_s" do
    it "translates card names" do
      expect(card.to_s).to eq("5 of clubs")
    end
  end

end

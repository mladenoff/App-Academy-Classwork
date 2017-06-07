require 'rspec'
require 'tdd'

describe "#my_uniq" do

  it "return an array without duplicates" do
    expect([1,1,2,3].my_uniq).to eq([1,2,3])
  end

  it "return same array if no duplicates" do
    expect([1,2,3,4].my_uniq).to eq([1,2,3,4])
  end
end

describe "#two_sum" do
  it "finds inidicies where the elements at those positions sum to zero" do
    expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
  end

  it "finds no indicies when no elements sum to zero" do
    expect([5,6,7,8].two_sum).to eq(nil)
  end

  it "doesn't return two indicies of the same zero" do
    expect([0].two_sum).not_to eq([[0,0]])
  end
end

describe "#my_transpose" do
  it "correctly converts arrays from rows to columns" do
    expect(my_transpose([[0, 1, 2], [3, 4, 5], [6, 7, 8]])).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end

  it "returns an empty array if given one" do
    expect(my_transpose([])).to eq([])
  end
end

describe "#stock_picker" do
  subject(:stocks) {[100, 150, 200, 150, 50]}

  it "selects stocks with highest profit" do
    expect(stock_picker(stocks)).to eq([0, 2])
  end

  it "buys before it sells" do
    expect(stock_picker(stocks)[0] <=> stock_picker(stocks)[1]).to eq(-1)
  end

end

describe TowersOfHanoi do


  describe "#intialize" do
    subject(:game) { TowersOfHanoi.new }
    it "starts game with three towers" do
      expect(game.towers.length).to eq(3)
    end

    it "the first tower has three disks" do
      expect(game.towers[0]).to eq([3,2,1])
    end

    it "the second and third towers are empty" do
      expect(game.towers[1] + game.towers[2]).to eq([])
    end
  end


  describe "#move" do
    subject(:game) { TowersOfHanoi.new }
      before(:each) do
        game.towers = [[3,1], [2], []]
      end
      it "doesn't try to move from empty tower" do
        expect{ game.move([2,1]) }.to raise_error("Can't move from empty tower")
      end

      it "doesn't try to move a big piece on top of a small piece" do
        expect{ game.move([1,0]) }.to raise_error("Can't put big piece on small piece")
      end

      it "raise error if selecting a non-existent tower" do
        expect{ game.move([3,1]) }.to raise_error("Input valid tower")
      end
  end

  describe "#won?" do
    subject(:game) { TowersOfHanoi.new }
      before(:each) do
        game.towers = [[], [3,2,1], []]
      end
      it "returns true if won" do
        expect(game.won?).to be(true)
      end

    subject(:game) { TowersOfHanoi.new }
      before(:each) do
        game.towers = [[3], [2,1], []]
      end
      it "returns false if not won" do
        expect(game.won?).to be(false)
      end

    subject(:game) { TowersOfHanoi.new }
      before(:each) do
        game.towers = [[3,2,1], [], []]
      end
      it "returns false if in starting position" do
        expect(game.won?).to be(false)
      end

  end
end

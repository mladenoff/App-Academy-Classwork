
class Game
  attr_reader :fragment

  def initialize player1, player2
    @fragment = ""
    @player1 = player1
    @player2 = player2
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @possible_words = []
    @losses = Hash.new(0)
  end

  def play_round
    @possible_words = @dictionary
    while true
      take_turn(@current_player)
      if lose?
        break @losses[@current_player]+= 1
      else
        @fragment << @guess
        update_words
        next_player!
      end
    end
  end

  def run
    @current_player = @player1
    until @losses.values.any?{|x| x == 5}
      play_round
    end
  end

  private

  def record(player)
    'GHOST'[0...@losses[player]]
  end

  def update_words
    @possible_words = []
    @dictionary.each do |word|
      if word[0...@fragment.length] == @fragment
        @possible_words << word
      end
    end
  end

  def next_player!
    if @current_player == @player1
      @current_player = @player2
    else @current_player == @player2
      @current_player = @player1
    end
  end

  def take_turn(player)
    print "#{@current_player.name}"
    @guess = @current_player.guess(fragment)
    until valid_play?(@guess)
      # i = @current_player.guess(fragment)
      @current_player.alert_invalid_guess
      @guess = @current_player.guess(fragment)
    end
  end

  def valid_play?(str)
    storage = @fragment + str
    p storage
    @possible_words.each do |word|
      if word[0...storage.length] == storage
        return true
      end
    end
    false
  end

  def lose?
    @possible_words.each { |x| return true if x == @fragment }
    false
  end

end

class Player

  attr_reader :name
  attr_accessor :score

  def initialize name
    @name = name
    @score = 0
  end

  def guess(fragment)
    print "Enter your letter:"
    letter = gets.chomp
    letter
  end

  def alert_invalid_guess
    print "This is not a valid letter. "
  end

end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("something")
  player2 = Player.new("other")
  game = Game.new(player1, player2)
  game.run
end

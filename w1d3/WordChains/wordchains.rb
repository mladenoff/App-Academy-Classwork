require 'set'

class WordChainer

  ALPHABET = ("a".."z").to_a

  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
  end

  def adjacent_words(word)
    words = []
    word.length.times do |i|
      ALPHABET.each do |letter|
        letters = word.chars
        letters[i] = letter
        words << letters.join if @dictionary.include?(letters.join)
      end
    end
    words.delete(word)
    words
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}
    until @current_words.empty?
      x = explore_current_words
      @current_words = x
    end

    build_path(target)
  end
end

def explore_current_words
  new_current_words = []
  @current_words.each do |word|
    adjacent_words(word).each do |a_word|
      unless @all_seen_words.include?(a_word)
        new_current_words << a_word
        @all_seen_words[a_word] = word
      end
    end
  end
  new_current_words.each {|word| puts "#{word}, from #{@all_seen_words[word]}"}
end

def build_path(target)
  path = []
  return [target] if @all_seen_words[target].nil?
  path += [target]
  path += build_path(@all_seen_words[target])
  path
end

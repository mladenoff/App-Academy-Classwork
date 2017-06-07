# PHASE 2
class Coffee < StandardError
end


def convert_to_int(str)
  Integer(str)
rescue ArgumentError => e
    puts "Couldn't convert string to Integer"
    puts "Error was #{e}"
    return nil
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == 'coffee'
    raise Coffee
  else
    raise StandardError
  end

end
def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit)
rescue Coffee => c
retry
rescue StandardError => s
  puts "#{maybe_fruit} is no bueno because of #{s}"
end


class FriendError < StandardError
end

class EmptyNameError < StandardError
end

class EmptyPastimeError < StandardError
end



# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
    raise FriendError if yrs_known < 5
    raise EmptyNameError if name == ''
    raise EmptyPastimeError if fav_pastime == ''
    rescue FriendError => f
      puts "You must be friends for more than 5 years"
    rescue EmptyNameError => n
      puts "I want to know your name"
    rescue EmptyPastimeError => t
      puts "Please tell me your pastime"
      @fav_pastime = gets.chomp
      BestFriend.new(@name, @yrs_known, @fav_pastime)
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end

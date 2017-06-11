require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    p key
    if @map.include?(key)

      @store.remove(key)

      @store.last.next = @map[key]

      @map[key].prev = @store.last



    else
      calc!(key)
    end
    @store.get(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @map.set(key, @store.append(key, @prc.call(key)))
    eject! if count > @max
  end

  def update_link!(link)

  end

  def eject!
    @map.delete(@store.first.key)
    @store.first.remove
  end
end

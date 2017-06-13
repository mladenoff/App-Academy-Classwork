require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

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
    if @map.include?(key)
      update_link!(@map[key])
      @map[key].val
    else
      calc!(key)
    end
    #@store.get(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    @map.set(key, @store.append(key, val))
    eject! if count > @max
    val
  end

  def update_link!(link)
    link.remove
    @map[link.key] = @store.append(link.key, link.val)
  end

  def eject!
    @map.delete(@store.first.key)
    @store.first.remove
  end
end

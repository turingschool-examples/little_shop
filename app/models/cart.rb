class Cart
  attr_reader :contents

  def initialize(contents)
    if contents
      @contents = contents
      @contents.default = 0
    else
      @contents = Hash.new(0)
    end
  end

  def add_item(item_id)
    @contents[item_id.to_s] += 1
  end

  def remove_item(item_id)
    @contents.delete(item_id.to_s)
  end

  def decrease_count(item_id)
    @contents[item_id.to_s] -= 1  
  end

  def total
    @contents.values.sum
  end

  def item_count(item_id)
    @contents[item_id.to_s]
  end
end

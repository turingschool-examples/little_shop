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

  def total
    @contents.values.sum
  end

  def item_count(item_id)
    @contents[item_id.to_s]
  end

  def item_ids
    @contents.map do |item_id, quantity|
      item_id.to_i
    end
  end

  def subtotal(item_id)
    item = Item.find(item_id)
    item_count(item_id) * item.price
  end

  def grandtotal(item_id)
    @contents.keys.sum do |item_id|
      subtotal(item_id)
    end
  end
end

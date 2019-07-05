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

  def item_count(item_id)
    @contents[item_id.to_s]
  end

  def total
    @contents.values.sum
  end

  def subtotal(item_id)
    current_item = Item.find(item_id)
    # binding.pry
    current_item.price * item_count(item_id)
  end

  def grand_total
    @contents.sum do |item_id, quanitity|
      subtotal(item_id)
    end
  end

  def empty?
    @contents == {}
  end

  def remove_item(item_id)
    @contents.delete(item_id)
  end

  def update_quantity(item_id, new_quantity)
    @contents[item_id] = new_quantity.to_i
  end
end

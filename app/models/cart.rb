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

  def total
    @contents.values.sum
  end

  def add_item(item_id)
    @contents[item_id.to_s] += 1
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def subtotal(price, quantity)
    price * quantity.to_f
  end

end

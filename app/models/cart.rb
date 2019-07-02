class Cart
  attr_reader :items, :num_items
  def initialize
    @items = []
    @num_items = 0
  end

  def add_to_cart(item)
    @num_items += 1
    @items << item
  end


end

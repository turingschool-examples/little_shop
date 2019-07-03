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
    #total items in cart
    @contents.values.sum
  end

  def subtotal(item_id)
    current_item = Item.find(item_id)
    current_item.price * item_count(item_id)
  end

   def grand_total
    # subtotal * item_count
    @contents.sum do |item_id, quanitity|
      subtotal(item_id)
    # end.sum do |item|
    #   item.quanitity
     end
   end
end

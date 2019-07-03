class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
    @contents.default = 0
  end

  def total_count
    @contents.values.sum
  end

  def total_cost
    @contents.map do |id,qty|
      Item.find(id).price * qty
    end.sum
  end

  def add_item(id)
    @contents[id.to_s] += 1
  end

  def has_inventory?(item)
    @contents[item.id.to_s] < item.inventory
  end

  def remove_item(id)
    @contents.delete(id.to_s)
  end

  def minus_item(id)
    item = Item.find(id)
    @contents[item.id.to_s] -= 1
    remove_item(id) if @contents[item.id.to_s] < 1
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def items
    @contents.map do |id,qty|
      [Item.find(id),qty]
    end
  end
end

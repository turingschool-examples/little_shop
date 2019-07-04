# frozen_string_literal: true

class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
    @contents.default = 0
  end

  def total_count
    @contents.values.sum
  end

  def count_of(item_id)
    @contents[item_id.to_s].to_i
  end

  def add_item(item_id)
    @contents[item_id.to_s] += 1
  end

  def item_and_quantity
    @contents.map do |item_id, quantity|
      item_id.to_i
    end
  end

  def list_items
    @items = Item.find(@cart)
  end

  def subtotal(item_id)
    item = Item.find(item_id)
    item.price * count_of(item_id)
  end

  def total(item_id)
    @contents.keys.sum do |item_id|
      subtotal(item_id)
    end
  end
end

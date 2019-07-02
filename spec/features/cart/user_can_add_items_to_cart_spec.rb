# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'When a user adds an item to their cart' do
  it 'displays a message' do
    merchant1 = Merchant.create!(name: 'Kaiju', address: '1531 Madison Ave', city: 'New York', state: 'NY', zip: '10005', image: 'https://cdn.shopify.com/s/files/1/0584/3841/products/vinyl-kaiju-dunny-battle-3-mini-figure-series-by-kidrobot-x-clutter-18_1200x.gif?v=1550786302')
    item1 = merchant1.items.create!(name: 'Apocalypse Benny', description: 'Tough construction worker', price: 2.29, active: true, inventory: 10, image: 'https://www.lego.com/r/www/r/catalogs/-/media/catalogs/characters/minifigures/2019/71023-11.jpg?l.r=1927415428')
    item2 = merchant1.items.create!(name: 'Awesome Remix Emmet', description: 'All star DJ', price: 2.99, active: true, inventory: 13, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-02?width=744&ratio=1&imageUrl=https%3A%2F%2Fwww.lego.com%2Fr%2Fwww%2Fr%2Fcatalogs%2F-%2Fmedia%2Fcatalogs%2Fcharacters%2Fminifigures%2F2019%2F71023-02.jpg%3Fl.r%3D340680808')

    visit "/items/#{item1.id}"
    click_button 'Add Item'

    visit "/items/#{item2.id}"
    click_button 'Add Item'

    visit "/items/#{item1.id}"
    click_button 'Add Item'

    expect(page).to have_content("You now have 2 #{item1.name} in your cart.")
  end

  it 'displays the total number of items in the cart' do
    merchant1 = Merchant.create!(name: 'Kaiju', address: '1531 Madison Ave', city: 'New York', state: 'NY', zip: '10005', image: 'https://cdn.shopify.com/s/files/1/0584/3841/products/vinyl-kaiju-dunny-battle-3-mini-figure-series-by-kidrobot-x-clutter-18_1200x.gif?v=1550786302')
    item1 = merchant1.items.create!(name: 'Apocalypse Benny', description: 'Tough construction worker', price: 2.29, active: true, inventory: 10, image: 'https://www.lego.com/r/www/r/catalogs/-/media/catalogs/characters/minifigures/2019/71023-11.jpg?l.r=1927415428')
    item2 = merchant1.items.create!(name: 'Awesome Remix Emmet', description: 'All star DJ', price: 2.99, active: true, inventory: 13, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-02?width=744&ratio=1&imageUrl=https%3A%2F%2Fwww.lego.com%2Fr%2Fwww%2Fr%2Fcatalogs%2F-%2Fmedia%2Fcatalogs%2Fcharacters%2Fminifigures%2F2019%2F71023-02.jpg%3Fl.r%3D340680808')

    visit "/items/#{item1.id}"

    expect(page).to have_content('Cart: 0')
    click_button 'Add Item'

    expect(page).to have_content('Cart: 1')
    click_button 'Add Item'

    expect(page).to have_content('Cart: 2')
    click_button 'Add Item'

    expect(page).to have_content('Cart: 3')
  end
end

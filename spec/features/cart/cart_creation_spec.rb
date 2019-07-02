
require 'rails_helper'

RSpec.describe "When a user adds an item to their cart" do
  it "displays a message" do
    megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    item_1 = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    item_2 = megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

    visit "/items"

    expect(page).to have_content("Cart: 0")

    click_on "Ogre"

    expect(current_path).to eq("/items/#{item_1.id}")

    click_on "Add To Cart"

    expect(page).to have_content("Cart: 1")

    expect(page).to have_content("#{item_1.name} has been added your cart.")
  end
end


# User Story 5, Cart Creation
#
# As a visitor
# When I visit an item's show page from the items index
# I see a link or button to add this item to my cart
# And I click this link or button
# I am returned to the item index page
# I see a flash message indicating the item has been added to my cart
# The cart indicator in the navigation bar increments my cart count

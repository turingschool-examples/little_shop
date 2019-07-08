
require 'rails_helper'

RSpec.describe "When a user looks at their cart" do
  it "they can increment the quantity of an item but no further than the inventory allows" do
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


    click_on "Giant"
    expect(current_path).to eq("/items/#{item_2.id}")
    click_on "Add To Cart"
    expect(page).to have_content("Cart: 2")
    expect(page).to have_content("#{item_2.name} has been added your cart.")

    click_on "Cart: 2"

    expect(current_path).to eq("/cart")


    #Inventory for this item contains 5, test for five iterations
    within "#item-#{item_1.id}" do
      expect(page).to have_button("Add 1 to Cart")
      click_on "Add 1 to Cart"
      expect(page).to have_button("Add 1 to Cart")
      click_on "Add 1 to Cart"
      expect(page).to have_button("Add 1 to Cart")
      click_on "Add 1 to Cart"
      expect(page).to have_button("Add 1 to Cart")
      click_on "Add 1 to Cart"
      expect(page).to_not have_button("Add 1 to Cart")
    end

    #Inventory for this item contains 3, test for three iterations
    within "#item-#{item_2.id}" do
      expect(page).to have_button("Add 1 to Cart")
      click_on "Add 1 to Cart"
      expect(page).to have_button("Add 1 to Cart")
      click_on "Add 1 to Cart"
      expect(page).to_not have_button("Add 1 to Cart")
    end

  end

end

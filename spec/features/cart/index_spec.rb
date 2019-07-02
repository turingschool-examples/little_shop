require 'rails_helper'

RSpec.describe "When a user adds an item to their cart" do
  it "displays a message" do
    megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    item_1 = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    item_2 = megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    binding.pry

    visit "/items"

    click_on "Ogre"

    expect(current_path).to eq("/items/#{item_1.id}")

    click_on "Add To Cart"

    expect(page).to have_content("Cart: 1")

    click_on "Ogre"

    expect(current_path).to eq("/items/#{item_1.id}")

    click_on "Add To Cart"

    expect(page).to have_content("Cart: 2")

    expect(page).to have_content("#{item_1.name} has been added your cart.")

    click_on "Giant"

    expect(current_path).to eq("/items/#{item_2.id}")

    click_on "Add To Cart"

    expect(page).to have_content("Cart: 3")

    visit '/cart'

    expect(page).to have_content("Ogre")
    expect(page).to have_css("img[src*='#{item_1.image}']")
    expect(page).to have_content("#{item_1.merchant.name}")
    expect(page).to have_content("#{item_1.price}")
    expect(page).to have_content("2")
    expect(page).to have_content("$40.00")

    expect(page).to have_content("Giant")
    expect(page).to have_css("img[src*='#{item_2.image}']")
    expect(page).to have_content("#{item_2.merchant.name}")
    expect(page).to have_content("#{item_2.price}")
    expect(page).to have_content("1")
    expect(page).to have_content("$50.00")

    expect(page).to have_content("$90.00")
  end
end

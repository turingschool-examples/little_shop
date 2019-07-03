require "rails_helper"

RSpec.describe "Cart", type: :feature do
  before(:each) do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
  end

  describe "As a visitor" do
    it "I see a cart indicator in my navigation bar" do
      visit '/items'
      # visit items_path

      expect(page).to have_content("Cart: 0")

      visit '/merchants'
      # visit merchants_path

      expect(page).to have_content("Cart: 0")

      visit "/merchants/#{@megan.id}"
      # visit merchants_path(@megan)

      expect(page).to have_content("Cart: 0")
    end
  end

  it "cart increments for multiple items" do
    visit "/items"

    click_on(@hippo.name)
    expect(current_path).to eq("/items/#{@hippo.id}")

    within "#item-#{@hippo.id}" do
      expect(page).to have_button("Add Item")
      click_button("Add Item")
    end
    expect(page).to have_content("Cart: 1")
    expect(current_path).to eq("/items")
    click_on(@giant.name)
    expect(current_path).to eq("/items/#{@giant.id}")

    within "#item-#{@giant.id}" do
      expect(page).to have_button("Add Item")
      click_button("Add Item")
    end
    expect(page).to have_content("Cart: 2")
    expect(current_path).to eq("/items")

    click_on(@ogre.name)
    expect(current_path).to eq("/items/#{@ogre.id}")

    within "#item-#{@ogre.id}" do
      expect(page).to have_button("Add Item")
      click_button "Add Item"
    end
    expect(current_path).to eq("/items")
    expect(page).to have_content("Cart: 3")
  end
end

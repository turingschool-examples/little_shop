require 'rails_helper'

RSpec.describe 'Cart Show Page' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

    end
    it "I can see number of items in the cart" do
    visit "/items/#{@giant.id}"
          click_button 'Add Giant to Cart'
    visit "/items/#{@hippo.id}"
          click_button 'Add Hippo to Cart'
    expect(page).to have_content("Cart: 2")
    end

    it "I can see the content in the cart" do
     cart = Cart.new
     cart.add_item(@giant.id)
     cart.add_item(@giant.id)
     cart.add_item(@hippo.id)
     visit "/cart"
      expect(page).to have_content(@giant.name)
      expect(page).to have_content(@giant.price)
      expect(page).to have_content(@hippo.name)
      expect(page).to have_content(@hippo.price)


      # expect(page).to have_content(@hippo.quantity)
      # expect(page).to have_content(@hippo.quantity)

    end
  end
end

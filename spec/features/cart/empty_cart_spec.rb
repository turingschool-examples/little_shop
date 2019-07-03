require 'rails_helper'

RSpec.describe "When a user has an empty cart" do
  it "the empty cart button does not display" do
    visit '/cart'

    expect(page).to have_content("You have no items in your cart")
    expect(page).to have_no_button('Empty Cart')
  end
end

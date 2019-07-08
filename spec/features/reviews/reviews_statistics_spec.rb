RSpec.describe 'Item Show Page' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @review1 = @giant.reviews.create!(title: "Damn!", rating: 5, body: "Definitely a Giant. No argument there")
      @review2 = @giant.reviews.create!(title: "Disappointed...", rating: 1, body: "Idk what I was expecting but I was disappointed.")
      @review3 = @giant.reviews.create!(title: "Fair.", rating: 3, body: "Not thrilled or upset. Was as expected for price.")
      @review4 = @giant.reviews.create!(title: "Pretty Good.", rating: 4, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")
    end

    describe "user can see stats about reviews present" do

      it "user can see top three rated reviews" do
        top_three = [@review1, @review4, @review3]
        expect(Review.top_three_rated(@giant)).to eq(top_three)

        visit "/items/#{@giant.id}"

        within '#top_three_css' do

          within "#review-#{@review1.id}" do
              expect(page).to have_content("Damn! - Rating: 5")
          end

          within "#review-#{@review4.id}" do
            expect(page).to have_content("Pretty Good. - Rating: 4")
          end

          within "#review-#{@review3.id}" do
            expect(page).to have_content("Fair. - Rating: 3")
          end
        end
      end

      it "user can see bottom three rated reviews" do
        bottom_three = [@review2, @review3, @review4]
        expect(Review.bottom_three_rated(@giant)).to eq(bottom_three)

        visit "/items/#{@giant.id}"

        within '#bottom_three_css' do

          within "#review-#{@review2.id}" do
              expect(page).to have_content("Disappointed... - Rating: 1")
          end

          within "#review-#{@review3.id}" do
            expect(page).to have_content("Fair. - Rating: 3")
          end

          within "#review-#{@review4.id}" do
            expect(page).to have_content("Pretty Good. - Rating: 4")
          end
        end
      end

      it "user can see average rating of all reviews" do

        visit "/items/#{@giant.id}"

        expect(page).to have_content("Average Rating: 3.25")

      end

    end

  end
end

require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'
  
      10.times do |n|
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
      end
    end
  
    scenario "They see the specific product page" do
      visit root_path
      # puts page.html
      page.first('.btn-primary', text: 'Add').click
  
      expect(page).to have_text "My Cart (1)"
  
      save_screenshot 'update_cart.png'
    end
end

require 'spec_helper'

RSpec.feature 'Managing volume price models' do
  stub_authorization!

  scenario 'a admin can create and remove volume price models', :js do
    visit spree.admin_volume_price_models_path
    expect(page).to have_content('Volume Price Models')

    click_on 'New Volume Price Model'
    fill_in 'Name', with: 'Discount'
    within '#volume_prices' do
      fill_in 'volume_price_model_volume_prices_attributes_0_name', with: '5 pieces discount'
      select 'Total price', from: 'volume_price_model_volume_prices_attributes_0_discount_type'
      fill_in 'volume_price_model_volume_prices_attributes_0_range', with: '1..5'
      fill_in 'volume_price_model_volume_prices_attributes_0_amount', with: '1'
    end
    click_on 'Create'

    within 'tr.volume_price.fields' do
      expect(page).to have_field('volume_price_model_volume_prices_attributes_0_name', with: '5 pieces discount')
      page.find('a[data-action="remove"]').click
      expect(page).to_not have_field('volume_price_model_volume_prices_attributes_0_name', with: '5 pieces discount')
    end
  end
end

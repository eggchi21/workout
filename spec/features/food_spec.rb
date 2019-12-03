require 'rails_helper'

feature 'food', type: :feature do
  let(:user) { create(:user) }

  scenario 'post food' do

    visit root_path
    expect(page).to have_content('たべもの図鑑')
    click_link('たべもの図鑑')
    expect(current_path).to eq foods_path
  end
end

require 'features/features_spec_helper'

RSpec.feature 'Registration', type: :feature do
  scenario 'Visitor registers successfully via register form' do
    visit root_path

    within '#register_form' do
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: Faker::Internet.password(10, 20)
      click_button('Sign up')
    end

    expect(page).not_to have_content 'Sign up'
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'You registered'
  end
end

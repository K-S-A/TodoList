require 'features/features_spec_helper'

RSpec.feature 'Registration', type: :feature, js: true do
  scenario 'Visitor registers successfully via register form' do
    visit root_path
    click_on 'Register'

    within '#loginForm' do
      fill_in 'E-mail', with: Faker::Internet.email
      fill_in 'Password', with: Faker::Internet.password(10, 20)
      find('input[type="submit"]').click
    end

    expect(page).not_to have_content 'Register'
    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'You\'re registered'
  end
end

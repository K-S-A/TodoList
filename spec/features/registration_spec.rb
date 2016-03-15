require 'features/features_spec_helper'

RSpec.feature 'Registration', :js do
  given(:first_name) { Faker::Name.first_name }
  given(:last_name) { Faker::Name.last_name }

  scenario 'Visitor registers successfully via register form' do
    visit root_path
    click_on 'Register'

    within '#loginForm' do
      fill_in 'email', with: Faker::Internet.email
      fill_in 'password', with: Faker::Internet.password(10, 20)
      fill_in 'first_name', with: first_name
      fill_in 'last_name', with: last_name

      find('input[type="submit"]').click
    end

    expect(page).not_to have_content 'Register'
    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'You are registered'
    expect(page).to have_content first_name
    expect(page).to have_content last_name
  end
end

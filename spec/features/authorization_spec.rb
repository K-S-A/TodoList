require 'features/features_spec_helper'

RSpec.feature 'Authorization', :js do
  given(:valid_user) { FactoryGirl.build(:user) }
  given(:save_user) { valid_user.save }

  scenario 'Visitor registers successfully via register form' do
    visit root_path
    click_on 'Register'

    within '#registration_form' do
      fill_in 'email', with: valid_user.email
      fill_in 'password', with: valid_user.password
      fill_in 'first_name', with: valid_user.first_name
      fill_in 'last_name', with: valid_user.last_name

      find('input[type="submit"]').click
    end

    expect(page).not_to have_content 'Register'
    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'You are registered'
    expect(page).to have_content valid_user.first_name
    expect(page).to have_content valid_user.last_name
  end

  scenario 'Registered visitor logs in successfully' do
    visit root_path
    click_on 'Log In'
    save_user

    within '#login_form' do
      fill_in 'email', with: valid_user.email
      fill_in 'password', with: valid_user.password

      find('input[type="submit"]').click
    end

    expect(page).not_to have_content 'Log In'
    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'You are authorized'
    expect(page).to have_content valid_user.first_name
    expect(page).to have_content valid_user.last_name
  end

  scenario 'Authorized user logs out successfully' do
    save_user
    login_as valid_user
    visit root_path

    click_on 'Log Out'

    expect(page).not_to have_content 'Log Out'
    expect(page).to have_content 'signed out'
  end


  scenario 'Visitor can\'t log in without registration' do
    visit root_path
    click_on 'Log In'

    within '#login_form' do
      fill_in 'email', with: valid_user.email
      fill_in 'password', with: valid_user.password

      find('input[type="submit"]').click
    end

    expect(page).not_to have_content 'Log Out'
    expect(page).to have_content 'Wrong user credentials'
  end
end

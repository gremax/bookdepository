require 'rails_helper'

feature 'User signin', %q{
  In order to be able to buy books
  As a registered user
  I want to be able to sign in
} do

  scenario 'Registered user try to sign in' do
    user = create(:user)

    visit root_path
    click_on 'Sign in'
    within '#new_session' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Sign in'
    end
    expect(page).to have_content "Welcome back, #{user.firstname}!"
    expect(page).to have_content 'Sign out'
    expect(page).to_not have_content 'Sign up'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit signin_path
    within '#new_session' do
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: '12345678'
      click_on 'Sign in'
    end
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Invalid combination'
    expect(page).to_not have_content 'Sign out'
    expect(current_path).to eq signin_path
  end
end

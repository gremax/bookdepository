require 'rails_helper'

feature 'User signup', %q{
  In order to be able to buy books
  As a visitor
  I want to be able to sign up
} do

  scenario 'Visitor registers successfully via register form' do
    visit signup_path
    within '#new_user' do
      fill_in 'First Name', with: Faker::Name.first_name
      fill_in 'Last Name', with: Faker::Name.first_name
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'
    end
    expect(page).to_not have_content 'Sign up'
    expect(page).to have_content 'Sign out'
    expect(page).to have_content "Welcome aboard"
  end

  scenario 'Visitor registers unsuccessful via register form' do
    visit signup_path
    within '#new_user' do
      click_on 'Sign up'
    end
    expect(page).to_not have_content 'Sign out'
    expect(page).to have_content 'Sign up'
    expect(page).to have_content 'some errors'
    expect(page).to have_selector 'div.errors ul li'
    visit root_path
    expect(page).to_not have_content 'some errors'
  end
end

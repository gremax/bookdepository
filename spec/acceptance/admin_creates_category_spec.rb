require 'rails_helper'

feature 'Create category', %q{
  In order to add a book to the category
  As an administrator
  I want to be able to create categories
} do

  given(:admin) { create(:admin) }
  given(:user) { create(:user) }

  scenario 'Authorized user creates a category with valid attributes' do
    category = build(:category)
    sign_in(admin)
    visit categories_path
    click_on 'Add new category'
    within '#new_category' do
      fill_in 'Title', with: category.title
      click_on 'Submit'
    end
    expect(page).to have_css '.alert', text: 'The category successfully created.'
    expect(page).to have_content category.title
    expect(current_path).to eq categories_path
  end

  scenario 'Authorized user creates a category with invalid attributes' do
    sign_in(admin)
    visit new_category_path
    within '#new_category' do
      fill_in 'Title', with: ''
      click_on 'Submit'
    end
    expect(page).to have_css '.alert', text: 'The form contains some errors.'
    expect(page).to have_css '.errors', text: 'can\'t be blank'
  end

  scenario 'Non-authorized user tries to create a category' do
    sign_in(user)
    visit new_category_path
    expect(page).to have_css '.alert', text: 'You need to sign in as administrator'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user tries to create a category' do
    visit new_category_path
    expect(page).to have_css '.alert', text: 'You need to sign in or sign up'
    expect(current_path).to eq root_path
  end
end

require 'rails_helper'

feature 'Edit category', %q{
  In order to update the category name
  As an administrator
  I want to be able to edit the categories
} do

  given(:admin) { create(:admin) }
  given(:user) { create(:user) }
  given!(:category) { create(:category) }

  scenario 'Authorized user edits the category name with valid attribute' do
    sign_in(admin)
    visit categories_path
    click_on 'Edit'
    within '.edit_category' do
      fill_in 'Title', with: 'new category name'
      click_on 'Submit'
    end
    expect(current_path).to eq categories_path
    expect(page).to have_css '.alert', text: 'The category successfully updated.'
    expect(page).to have_content 'new category name'
  end

  scenario 'Authorized user edits the category with invalid attribute' do
    sign_in(admin)
    visit categories_path
    click_on 'Edit'
    within '.edit_category' do
      fill_in 'Title', with: ''
      click_on 'Submit'
    end
    expect(current_path).to eq category_path(category)
    expect(page).to have_css '.alert', text: 'The form contains some errors.'
    expect(page).to have_css '.errors', text: 'can\'t be blank'
  end

  scenario 'Non-authorized user tries to edit the category' do
    sign_in(user)
    visit edit_category_path(category)
    expect(page).to have_css '.alert', text: 'You need to sign in as administrator'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user tries to edit the category' do
    visit edit_category_path(category)
    expect(page).to have_css '.alert', text: 'You need to sign in or sign up'
    expect(current_path).to eq root_path
  end
end

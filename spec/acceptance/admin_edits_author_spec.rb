require 'rails_helper'

feature 'Edit author', %q{
  In order to update the author info
  As an administrator
  I want to be able to edit the authors
} do

  given(:admin) { create(:admin) }
  given(:user) { create(:user) }
  given!(:author) { create(:author) }

  scenario 'Authorized user edits the author with valid attributes' do
    sign_in(admin)
    visit authors_path
    click_on 'Edit'
    within '.edit_author' do
      fill_in 'First Name', with: 'Andy'
      fill_in 'Last Name',  with: 'Weir'
      click_on 'Submit'
    end
    expect(current_path).to eq authors_path
    expect(page).to have_css '.alert', text: 'The author successfully updated.'
    expect(page).to have_css 'a',      text: 'Andy Weir'
  end

  scenario 'Authorized user edits the author with invalid attributes' do
    sign_in(admin)
    visit authors_path
    click_on 'Edit'
    within '.edit_author' do
      fill_in 'First Name', with: ''
      fill_in 'Last Name',  with: ''
      click_on 'Submit'
    end
    expect(current_path).to eq author_path(author)
    expect(page).to have_css '.alert',  text: 'The form contains some errors.'
    expect(page).to have_css '.errors', text: 'can\'t be blank'
    visit root_path
    expect(page).to_not have_css '.alert'
  end

  scenario 'Non-authorized user tries to edit the author' do
    sign_in(user)
    visit edit_author_path(author)
    expect(page).to have_css '.alert', text: 'You need to sign in as administrator'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user tries to edit the author' do
    visit edit_author_path(author)
    expect(page).to have_css '.alert', text: 'You need to sign in or sign up'
    expect(current_path).to eq root_path
  end
end

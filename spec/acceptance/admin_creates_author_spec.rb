require 'rails_helper'

feature 'Create author', %q{
  In order to add an author to the book
  As an administrator
  I want to be able to create the author
} do

  given(:admin) { create(:admin) }
  given(:user) { create(:user) }

  scenario 'Authorized user creates an author with valid attributes' do
    author = build(:author)
    sign_in(admin)
    visit authors_path
    click_on 'Add new author'
    within '#new_author' do
      fill_in 'First Name', with: author.firstname
      fill_in 'Last Name',  with: author.lastname
      fill_in 'Biography',  with: author.biography
      click_on 'Submit'
    end
    expect(page).to have_css '.alert', text: 'The author successfully created.'
    expect(page).to have_css 'a', text: "#{author.firstname} #{author.lastname}"
    expect(current_path).to eq authors_path
  end

  scenario 'Authorized user creates an author with invalid attributes' do
    sign_in(admin)
    visit new_author_path
    within '#new_author' do
      fill_in 'First Name', with: ''
      fill_in 'Last Name',  with: ''
      click_on 'Submit'
    end
    expect(page).to have_css '.alert', text: 'The form contains some errors.'
    expect(page).to have_css '.errors', text: 'can\'t be blank'
    visit root_path
    expect(page).to_not have_css '.alert'
  end

  scenario 'Non-authorized user tries to create an author' do
    sign_in(user)
    visit new_author_path
    expect(page).to have_css '.alert', text: 'You need to sign in as administrator'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user tries to create an author' do
    visit new_author_path
    expect(page).to have_css '.alert', text: 'You need to sign in or sign up'
    expect(current_path).to eq root_path
  end
end

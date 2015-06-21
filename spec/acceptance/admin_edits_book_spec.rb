require 'rails_helper'

feature 'Edit book', %q{
  In order to update the book info
  As an administrator
  I want to be able to edit the books
} do

  given(:admin) { create(:admin) }
  given(:user) { create(:user) }
  given(:book) { create(:book) }

  scenario 'Authorized user edits the book with valid attributes' do
    sign_in(admin)
    visit book_path(book)
    click_on 'Edit'
    within '.edit_book' do
      fill_in 'Title',       with: 'new book title'
      fill_in 'Description', with: ''
      fill_in 'Price',       with: 3.14
      fill_in 'Stock',       with: 17
      click_on 'Submit'
    end
    expect(current_path).to eq book_path(book)
    expect(page).to have_css '.alert', text: 'The book successfully updated.'
    expect(page).to have_content 'new book title'
    expect(page).to have_content '3.14'
    expect(page).to have_content '17'
  end

  scenario 'Authorized user edits the book with invalid attributes' do
    sign_in(admin)
    visit book_path(book)
    click_on 'Edit'
    within '.edit_book' do
      fill_in 'Title',       with: ''
      fill_in 'Description', with: ''
      click_on 'Submit'
    end
    expect(current_path).to eq book_path(book)
    expect(page).to have_css '.alert', text: 'The form contains some errors.'
  end

  scenario 'Non-authorized user tries to edit the book' do
    sign_in(user)
    visit edit_book_path(book)
    expect(page).to have_css '.alert', text: 'You need to sign in as administrator'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user tries to edit the book' do
    visit edit_book_path(book)
    expect(page).to have_css '.alert', text: 'You need to sign in or sign up'
    expect(current_path).to eq root_path
  end

end

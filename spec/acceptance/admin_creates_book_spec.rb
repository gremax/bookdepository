require 'rails_helper'

feature 'Create book', %q{
  In order to add a book to Book Depository
  As an administrator
  I want to be able to create books
} do

  given(:admin) { create(:admin) }
  given(:user) { create(:user) }

  scenario 'Authorized user creates a book with valid attributes' do
    book = build(:book)
    sign_in(admin)
    visit books_path
    click_on 'Add new book'
    within '#new_book' do
      fill_in 'Title',       with: book.title
      fill_in 'Description', with: book.description
      fill_in 'Price',       with: book.price
      fill_in 'Stock',       with: book.stock
      click_on 'Add book'
    end
    expect(page).to have_content 'The book successfully added.'
    expect(page).to have_content book.title
  end

  scenario 'Authorized user creates a book with invalid attributes' do
    sign_in(admin)
    visit new_book_path
    within '#new_book' do
      fill_in 'Title', with: 'The Martian'
      fill_in 'Price', with: 0
      click_on 'Add book'
    end
    expect(page).to have_content 'The form contains some errors.'
  end

  scenario 'Non-authorized user creates a book' do
    sign_in(user)
    visit new_book_path
    expect(page).to have_content 'You need to sign in as administrator'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user creates a book' do
    visit new_book_path
    expect(page).to have_content 'You need to sign in or sign up'
    expect(current_path).to eq root_path
  end
end

require 'rails_helper'

feature 'Connect book to category', %q{
  In order to connect a book to a category
  As an administrator
  I want to be able to add the book to the category
} do

  given(:admin) { create(:admin) }
  given(:book) { create(:book) }
  given!(:categories) { create_list(:category, 5) }

  scenario 'Authorized user add the book category when creates a new book' do
    sign_in(admin)
    visit books_path
    click_on 'Add new book'
    within '#new_book' do
      fill_in 'Title', with: 'new book'
      fill_in 'Price', with: 13
      fill_in 'Stock', with: 21
      select categories.first.title, from: 'book_category_id'
      click_on 'Submit'
    end
    expect(page).to have_css '.alert', text: 'The book successfully added.'
    expect(page).to have_content categories.first
  end

  scenario 'Authorized user changes the book category' do
    book.save
    sign_in(admin)
    visit books_path
    click_on 'Edit'
    within '.edit_book' do
      select book.category.title, from: 'book_category_id'
      click_on 'Submit'
    end
    expect(page).to have_css '.alert', text: 'The book successfully updated.'
    expect(page).to have_content book.category.title
    expect(current_path).to eq book_path(book)
    visit edit_book_path(book)
    expect(page).to have_css 'option', text: book.category.title
    expect(page).to have_select 'book_category_id', selected: book.category.title
  end
end

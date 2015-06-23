require 'rails_helper'

feature 'Connect author to book', %q{
  In order to connect an author to a book
  As an administrator
  I want to be able to add the author to the book
} do

  given(:admin) { create(:admin) }
  given!(:book) { create(:book) }
  given!(:authors) { create_list(:author, 5) }

  scenario 'Authorized user choices the book author when creates a new book' do
    sign_in(admin)
    visit books_path
    click_on 'Add new book'
    within '#new_book' do
      fill_in 'Title', with: 'new book'
      fill_in 'Price', with: 13
      fill_in 'Stock', with: 21
      select authors.first.full_name, from: 'book_author_id'
      click_on 'Submit'
    end
    expect(page).to have_css '.alert', text: 'The book successfully added.'
    expect(page).to have_content authors.first.full_name
  end

  scenario 'Authorized user changes the book author' do
    sign_in(admin)
    visit books_path
    click_on 'Edit'
    within '.edit_book' do
      select book.author.full_name, from: 'book_author_id'
      click_on 'Submit'
    end
    expect(page).to have_css '.alert', text: 'The book successfully updated.'
    expect(page).to have_content book.author.full_name
    expect(current_path).to eq book_path(book)
    visit edit_book_path(book)
    expect(page).to have_select 'book_author_id', selected: book.author.full_name
  end
end

require 'rails_helper'

feature 'Delete book', %q{
  In order to remove a book from the store
  As an administrator
  I want to be able to delete the books
} do

  given(:admin) { create(:admin) }
  given(:user) { create(:user) }
  given(:book) { create(:book) }

  scenario 'Authorized user deletes the book from details page' do
    sign_in(admin)
    visit book_path(book)
    click_on 'Delete'
    expect(current_path).to eq books_path
    expect(page).to_not have_content book.title
    expect(page).to have_css '.alert', text: 'The book successfully removed.'
  end
end

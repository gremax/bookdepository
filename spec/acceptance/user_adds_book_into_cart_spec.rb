require 'rails_helper'

feature 'User adds a book into the shopping cart', %q{
  In order to be able to buy the books
  As a user
  I want to be able to add a book into the shopping cart
} do

  given(:user) { create(:user) }
  given!(:book) { create(:book) }
  given!(:category) { create(:category_with_books) }

  scenario 'Authorized user adds the book to the Cart' do
    sign_in(user)
    visit root_path
    click_on category.title
    click_on 'Add to Cart', match: :first
    expect(page).to have_css '.alert',
      text: 'The book successfully added to the Cart.'
  end

  scenario 'Authorized user adds the book to the Cart twice' do
    sign_in(user)
    visit root_path
    click_on book.title
    click_on 'Add to Cart'
    expect(page).to have_content book.price
    visit root_path
    click_on book.title
    click_on 'Add to Cart'
    expect(page).to have_content(book.price * 2)
  end

  scenario 'Visitor adds the book to the Cart' do
    visit root_path
    click_on category.title
    click_on 'Add to Cart', match: :first
    expect(page).to have_css '.alert', text: 'sign in or sign up'
    expect(page).to have_content 'Sign in'
  end
end

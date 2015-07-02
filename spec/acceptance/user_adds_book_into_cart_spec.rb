require 'rails_helper'

feature 'User adds a book into the shopping cart', %q{
  In order to be able to buy the books
  As a user
  I want to be able to add a book into the shopping cart
} do

  let!(:category) { create(:category_with_books) }

  scenario 'Authorized user adds the book to the Cart' do
    visit root_path
    click_on category.title
    click_on 'Add to Cart', match: :first
    expect(page).to have_css '.alert', text: 'The order item successfully created.'
  end

  scenario 'Visitor adds the book to the Cart' do
    visit root_path
    click_on category.title
    click_on 'Add to Cart', match: :first
    expect(page).to have_css '.alert', text: 'Please, sign up or sign in.'
    expect(page).to have_content 'Sign in'
  end
end

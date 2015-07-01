require 'rails_helper'

feature 'User navigates by categories', %q{
  In order to be able to see the books by a category
  As a visitor or a user
  I want to be able to choice the category
} do

  let(:user) { create(:user) }
  let!(:categories) { create_list(:category_with_books, 2) }

  scenario 'Visitor searches books by categories' do
    visit root_path
    categories.each do |category|
      expect(page).to have_css 'a', text: category.title
    end
    click_on categories.last.title
    expect(page).to have_css 'h1', text: categories.last.title
    categories.last.books.each do |book|
      expect(page).to have_css 'a', text: book.title
    end
    click_on categories.first.title
    expect(page).to have_css 'h1', text: categories.first.title
    categories.first.books.each do |book|
      expect(page).to have_css 'a', text: book.title
    end
  end

  scenario 'Authorized user searches books by categories' do
    sign_in(user)
    visit root_path
    categories.each do |category|
      expect(page).to have_css 'a', text: category.title
    end
    click_on categories.last.title
    expect(page).to have_css 'h1', text: categories.last.title
    categories.last.books.each do |book|
      expect(page).to have_css 'a', text: book.title
    end
    click_on categories.first.title
    expect(page).to have_css 'h1', text: categories.first.title
    categories.first.books.each do |book|
      expect(page).to have_css 'a', text: book.title
    end
  end
end

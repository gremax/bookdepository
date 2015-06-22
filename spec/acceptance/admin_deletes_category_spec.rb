require 'rails_helper'

feature 'Delete category', %q{
  In order to remove a category
  As an administrator
  I want to be able to delete the categories
} do

  given(:admin) { create(:admin) }
  given!(:category) { create(:category) }

  scenario 'Authorized user deletes the category from categories list' do
    sign_in(admin)
    visit categories_path
    click_on 'Delete'
    expect(current_path).to eq categories_path
    expect(page).to_not have_content category.title
    expect(page).to have_css '.alert', text: 'The category successfully removed.'
  end
end

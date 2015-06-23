require 'rails_helper'

feature 'Delete author', %q{
  In order to remove an author
  As an administrator
  I want to be able to delete the author
} do

  given(:admin) { create(:admin) }
  given!(:author) { create(:author) }

  scenario 'Authorized user deletes the author from authors list' do
    sign_in(admin)
    visit authors_path
    click_on 'Delete'
    expect(current_path).to eq authors_path
    expect(page).to_not have_content author.firstname
    expect(page).to have_css '.alert', text: 'The author successfully removed.'
  end
end

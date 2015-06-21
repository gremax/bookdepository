require 'rails_helper'

feature 'User signout', %q{
  As a signed in user
  I want to be able to sign out
  } do

  scenario 'Signed in user try to sign out' do
    user = create(:user)

    visit signin_path
    within '#new_session' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Sign in'
    end
    click_on 'Sign out'
    expect(page).to have_content 'Sign in'
    expect(page).to_not have_content 'Sign out'
    expect(current_path).to eq root_path
  end
end

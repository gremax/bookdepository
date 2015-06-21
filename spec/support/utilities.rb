module Utilities
  def sign_in(user, options={})
    if options[:no_capybara]
      session[:user_id] = user.id
    else
      visit signin_path
      within '#new_session' do
        fill_in 'Email',    with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end
    end
  end
end

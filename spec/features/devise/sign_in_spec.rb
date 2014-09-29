require 'acceptance_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an user
  I want to be able to sign in
} do

  background do
    clear_emails
  end

  given(:user) { create(:user) }

  scenario 'Registered user tries to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content user.email
    expect(page).to have_content 'Sign out'
    expect(current_path).to eq root_path
  end

  scenario 'Non-Registered user tries to sign in ' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@example.org'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email address or password.'
    expect(current_path).to eq new_user_session_path
  end



end
require 'acceptance_helper'

feature 'Recovery of lost password', %q{
  In order to recover acces to site
  As an registered user
  I want to recover lost password
} do

  given(:user) { create(:user) }

  scenario 'Registered user recovers password' do
    visit new_user_session_path

    click_on 'Forgot your password?'
    fill_in 'Email', with: user.email

    click_on 'Send me reset password instructions'

    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
    expect(current_path).to eq new_user_session_path

    open_email(user.email)
    current_email.click_on 'Change my password'

    fill_in 'New password', with: '1q2w3e4r5t'
    fill_in 'Confirm your new password', with: '1q2w3e4r5t'
    click_on 'Change my password'

    expect(page).to have_content 'Your password has been changed successfully. You are now signed in.'
    expect(page).to have_content user.email
    expect(page).to have_content 'Sign out'
    expect(current_path).to eq root_path
  end
end
require 'rails_helper'

feature 'User sign up', %q{
    In order to to be able to sign in
    As an user
    I want to sign up with email and password
} do

  given(:user_params) {attributes_for(:user)}

  scenario 'Non-Registered user tries to sign up' do
    visit root_path
    click_on 'Sign up'

    within '#new_user' do
      fill_in 'Email', with: user_params[:email]
      fill_in 'Password', with: user_params[:password], :match => :prefer_exact
      fill_in 'Password confirmation', with: user_params[:password], :match => :prefer_exact
      click_on 'Sign up'
    end
    expect(page).to have_content 'Welcome! You have signed up successfully.'

    expect(current_path).to eq root_path
    expect(page).to have_content user_params[:email]
    expect(page).to have_content 'Sign out'
  end
end
require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question!'
    fill_in 'Text', with: 'This is my question. Am I writing tests?'
    click_on 'Create Question'
    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'Test question!'
    expect(page).to have_content 'This is my question. Am I writing tests?'
  end

  scenario 'Authenticated user creates question with blank title and text' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: ''
    fill_in 'Text', with: ''

    click_on 'Create Question'

    expect(page).to have_content "Titlecan't be blank"
    expect(page).to have_content "Textcan't be blank"

  end

  scenario 'Authenticated user creates question with short title and text' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: '1'
    fill_in 'Text', with: '1'

    click_on 'Create Question'

    expect(page).to have_content "Titleis too short"
    expect(page).to have_content "Text1is too short"
  end

  scenario 'Non-authenticated user tries to create a question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
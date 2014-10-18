require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
} do

  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit questions_path
    end

    context 'creates new question' do
      background do
        click_on 'Ask question'
      end

      scenario 'with valid title and text' do
        fill_in 'Title', with: 'Test question!'
        fill_in 'Text', with: 'This is my question. Am I writing tests?'

        click_on 'Create Question'

        expect(page).to have_content 'Your question successfully created.'
        expect(page).to have_content 'Test question!'
        expect(page).to have_content 'This is my question. Am I writing tests?'
      end

      scenario 'with blank title and text' do
        fill_in 'Title', with: ''
        fill_in 'Text', with: ''

        click_on 'Create Question'

        within('.question_title') do
          expect(page).to have_content "can't be blank"
        end

        within('.question_text') do
          expect(page).to have_content "can't be blank"
        end
      end

      scenario 'with short title and text' do
        fill_in 'Title', with: '1'
        fill_in 'Text', with: '1'

        click_on 'Create Question'

        within '.question_title' do
          expect(page).to have_content 'is too short'
        end

        within '.question_text' do
          expect(page).to have_content 'is too short'
        end
      end

    end
  end

  describe 'Non-authenticated user' do
    scenario 'tries to create a question' do
      visit questions_path
      click_on 'Ask question'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
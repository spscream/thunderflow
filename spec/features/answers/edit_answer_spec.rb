require 'acceptance_helper'

feature 'Edit answer', %q{
    In order to to fix mistake in answer
    As an author of answer
    I want to edit answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthenticated user tries to edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit answer'
  end

  describe 'Authenticated user', js: true do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to Edit answer' do
      within ".answer-#{answer.id}" do
        expect(page).to have_selector '.answer-edit'
      end
    end

    context 'edits his answer', js: true do
      scenario 'with valid attributes' do
        within ".answer-#{answer.id}" do
          find('.answer-edit').click
          fill_in 'Text', with: 'Updated text of answer, for testing purposes.'
          find('.answer-save').click

          expect(page).to_not have_content answer.text
          expect(page).to have_content('Updated text of answer, for testing purposes.')
          expect(page).to have_selector('.answer-edit')
        end
      end

      scenario 'with invalid attributes' do
        within ".answer-#{answer.id}" do
          find('.answer-edit').click
          fill_in 'Text', with: ''
          find('.answer-save').click

          expect(page).to have_content('Text can not be blank.')
        end
      end
    end

    scenario 'tries to edit not his answer' do
      sign_out
      sign_in create(:user)
      visit question_path(question)

      expect(page).to_not have_link 'Edit answer'
    end
  end
end
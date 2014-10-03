require 'acceptance_helper'

feature 'Edit answer', %q{
    In order to to fix mistake in answer
    As an author of answer
    I want to edit answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario "Unauthenticated user tries to edit answer" do
    visit question_path(question)

    expect(page).to_not have_link 'Edit answer'
  end

  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to Edit answer' do
      within ".answer-#{answer.id}" do
        expect(page).to have_link 'Edit answer'
      end
    end

    scenario 'edits his answer', js: true do
      within ".answer-#{answer.id}" do
        click_on 'Edit answer'
        fill_in 'Text', with: 'Updated text of answer, for testing purposes.'
        click_on 'Update Answer'

        expect(page).to_not have_content answer.text
        expect(page).to have_content('Updated text of answer, for testing purposes.')
        expect(page).to have_selector('.answer-edit')
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
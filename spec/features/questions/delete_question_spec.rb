require 'acceptance_helper'

feature 'Delete question', %q{
  In order to remove wrong question
  As an aunthenticated user
  I want to be able delete questions
} do
  given (:user) {create(:user)}
  given! (:question) {create(:question, user: user)}

  describe 'Author of question', js: true do
    before do
      sign_in user
      visit questions_path
    end
    scenario 'sees link to delete question' do
      expect(page).to have_link('Delete question')
    end

    scenario 'deletes his question' do
      click_on 'Delete question'

      expect(page).to have_content 'Question was successfully destroyed.'
      expect(page).to_not have_content(question.title)
    end
  end

  scenario 'User cannot delete others questions', js: true do
    sign_in(create(:user))
    visit questions_path
    expect(page).to_not have_link('Delete question')
  end

  scenario 'Unauthenticated user tries to delete question', js: true do
    visit questions_path
    expect(page).to_not have_link('Delete question')
  end
end
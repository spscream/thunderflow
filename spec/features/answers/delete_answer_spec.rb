require 'acceptance_helper'

feature 'Delete answer', %q{
  In order to remove wrong answer
  As an aunthenticated user
  I want to be able delete answers
} do
  given (:user) {create(:user)}
  given! (:question) {create(:question, user: user)}
  given! (:answer) {create(:answer, user: user, question: question)}

  describe 'Author of answer', js: true do
    before do
      sign_in user
      visit question_path(question)
    end
    scenario 'sees link to delete answer' do
      expect(page).to have_link('Delete answer')
    end

    scenario 'deletes his answer' do
      click_on 'Delete answer'

      expect(page).to have_content 'Answer was successfully deleted'
      expect(page).to_not have_content(answer.text)
    end
  end

  scenario 'User cannot delete others answers', js: true do
    sign_in(create(:user))
    visit question_path(question)
    expect(page).to_not have_link('Delete answer')
  end

  scenario 'Unauthenticated user tries to delete answer', js: true do
    visit question_path(question)
    expect(page).to_not have_link('Delete answer')
  end
end
require 'acceptance_helper'

feature 'Create answer', %q{
  In order to help other users
  As an autenthicated user
  I want to be able to answer questions
} do
  given(:user) { create(:user) }
  given(:question) { create(:question)}

  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'creates an answer', js: true do
      fill_in 'Text', with: "I am answering on your question. Does it help you?"
      click_on 'Create Answer'

      expect(page).to have_content 'Answer successfully created.'
      within('.answers') do
        expect(page).to have_selector (".answer-#{question.answers.first.id}")
        expect(page).to have_content 'I am answering on your question. Does it help you?'
      end
      expect(current_path).to eq question_path(question)
    end

    scenario 'tries to create an answer with blank text' do
      fill_in 'Text', with: ""
      click_on 'Create Answer'

      expect(page).to have_content "Textcan't be blank"
    end
  end

  scenario 'Non-authenticated user tries to create an answer', js: true do
    visit question_path(question)

    expect(page).to_not have_link 'Create Answer'
  end

end
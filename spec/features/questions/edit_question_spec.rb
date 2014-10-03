require 'rails_helper'

feature 'Edit', %q{
    In order to fix mistakes in question
    As an author of question 
    I want to edit question
} do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}
  scenario 'Author can edit own question' do
    sign_in(user)

    visit question_path(question)
    click_on('Edit Question')
    expect(current_path).to eq edit_question_path(question)
    fill_in 'Title', with: 'New title is awesome'
    fill_in 'Text', with: 'New text is awesome too. What am I doing now?'

    click_on 'Update Question'

    expect(page).to have_content('Question was successfully updated.')
    expect(page).to have_content('New title is awesome')
    expect(page).to have_content('New text is awesome too. What am I doing now?')
  end

  scenario 'User cannot edit others question' do
    sign_in(create(:user))
    visit question_path(create(:question))

    expect(page).not_to have_link 'Edit'
  end

  scenario 'Guest cannot edit questions'  do
    visit question_path(create(:question))

    expect(page).not_to have_link 'Edit'
  end
end
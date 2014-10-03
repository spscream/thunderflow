require 'acceptance_helper'

feature 'Mark answer as accepted', %q{
    In order to be show that answer helped me to find solution
    As question author
    I want to mark one right answer as accepted
} do

  given (:user) {create(:user)}
  given (:question) {create(:question_with_answers, user: user)}

  scenario 'Author of question marks answer as accepted', js: true do
    sign_in(user)
    visit question_path(question)
    within('.answers') do
      first('.answer').click_button('Accept')
    end

    expect(page).to have_content('You accepted an answer.')
    within('.answers') do
      expect(page).to_not have_button('Accept')
    end
  end

  scenario 'Unauthenticated user tries to mark answer as accepted' do
    visit question_path(question)

    expect(page).to_not have_link 'Accept'
  end

  scenario 'Other user tries to mark answer as accepted' do
    sign_in(create(:user))
    visit question_path(question)

    expect(page).to_not have_link 'Accept'
  end
end
require 'acceptance_helper'

feature 'Mark answer as accepted', %q{
    In order to be show that answer helped me to find solution
    As question author
    I want to mark one right answer as accepted
} do

  given (:user) {create(:user)}
  given (:question) {create(:question_with_answers)}

  scenario 'Author of question marks answer as accepted', js: true do
    visit question_path(question)
    within('.answers') do
      first('.answer').click_button('Accept')
    end

    expect(page).to have_content('You accepted an answer.')
    within('.answers') do
      expect(page).to_not have_button('Accept')
    end
  end
end
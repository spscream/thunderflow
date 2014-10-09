require 'acceptance_helper'

feature 'Attach file', %q{
  In order to illustrate a question
  As an author of question
  I want to attach the file
} do
  given(:user) {create(:user)}

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User makes attachment when asks question' do
    fill_in 'Title', with: 'Test question!'
    fill_in 'Text', with: 'This is my question. Am I writing tests?'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create Question'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end
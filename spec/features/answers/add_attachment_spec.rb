require 'acceptance_helper'

feature 'Attach file', %q{
  In order to illustrate an answer
  As an author of answer
  I want to attach the file
} do
  given(:user) {create(:user)}
  given!(:question) {create(:question)}

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User makes attachment when creates answer', js: true do
    fill_in 'Text', with: 'This is my answer. And this is a file!'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create Answer'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end
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

  describe 'User makes answer', js: true do
    background do
      fill_in 'Text', with: 'This is my answer to this question.'
    end

    context 'without attachments' do
      scenario 'creates answer' do
        click_on 'Create Answer'

        expect(page).to have_content('This is my answer to this question.')
      end

      scenario 'clicks on "Add a file", but not adds a file' do
        click_on 'Add a file'
        click_on 'Create Answer'

        within '.answer_attachments_file' do
          expect(page).to have_content "can't be blank"
        end
      end
    end

    context 'with single attachment', js: true do
      scenario 'attaches it' do
        click_on 'Add a file'
        all("input[type='file']")[0].set("#{Rails.root}/spec/spec_helper.rb")
        click_on 'Create Answer'

        expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      end
    end

    context 'with multiple attachments' do

    end

  end
end
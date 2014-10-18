require 'acceptance_helper'

feature 'Attach file', %q{
  In order to illustrate a question
  As an author of question
  I want to attach the file
} do
  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  context 'User makes new question', js: true do
    background do
      fill_in 'Title', with: 'Test question!'
      fill_in 'Text', with: 'This is my question. Am I writing tests?'
    end

    context 'without attachments' do
      scenario 'creates question' do
        click_on 'Create Question'

        expect(page).to have_content('Test question!')
      end

      scenario 'clicks on "Add a file", but not adds a file' do
        click_on 'Add a file'
        click_on 'Create Question'

        within '.question_attachments_file' do
          expect(page).to have_content "can't be blank"
        end
      end
    end

    context 'with single attachment' do
      scenario 'attaches it' do
        click_on 'Add a file'
        all("input[type='file']")[0].set("#{Rails.root}/spec/spec_helper.rb")
        click_on 'Create Question'

        expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      end
    end

    context 'with multiple attachments' do
      background do
        click_on 'Add a file'
        all("input[type='file']")[0].set("#{Rails.root}/spec/spec_helper.rb")
        click_on 'Add a file'
        all("input[type='file']")[1].set("#{Rails.root}/spec/rails_helper.rb")
      end

      scenario 'attaches them all' do
        click_on 'Create Question'

        expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
        expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
      end

      scenario 'removes one before creating question' do
        all(".remove_nested_fields")[1].click
        click_on 'Create Question'

        expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
        expect(page).to_not have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
      end
    end

  end
end
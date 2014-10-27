require 'acceptance_helper'

feature 'Attach file', %q{
  In order to remove unnecessary attachments
  As an author of question
  I want to delete attachments
} do

  let(:user) { create(:user) }
  let(:question) { create(:question) }

end
require 'rails_helper'

RSpec.describe SocialAuthentication, :type => :model do
  it{should belong_to :user}

  describe '.find_for_oauth' do

  end
end

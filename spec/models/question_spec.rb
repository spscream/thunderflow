require 'rails_helper'

RSpec.describe Question, :type => :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :text }
  it { should ensure_length_of(:title).is_at_least(5).is_at_most(250) }
  it { should ensure_length_of(:text).is_at_least(15) }
  it { should have_many(:answers)}
end

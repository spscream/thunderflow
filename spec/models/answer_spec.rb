require 'rails_helper'

RSpec.describe Answer, :type => :model do
  it { should validate_presence_of :text }
  it { should belong_to(:question)}
  it { should belong_to(:user)}

  it 'should has a scope accepted' do
    answer1 = create(:answer, is_accepted: true)
    answer2 = create(:answer, is_accepted: false)
    expect(Answer.accepted).to eq [answer1]
  end
end
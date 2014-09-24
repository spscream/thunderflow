require 'rails_helper'

RSpec.describe Answer, :type => :model do
  it { should validate_presence_of :text }
  it { should belong_to(:question)}
  describe "#accepted?" do
    context 'when answer is accepted' do
      it 'returns true' do
        answer = create(:answer)
        question = answer.question
        question.accepted_answer = answer
        expect(answer.accepted?).to be true
      end
    end
    context 'when answer is not accepted' do
      it 'returns false' do
        answer = create(:answer)
        expect(answer.accepted?).to be false
      end
    end
  end
end
require 'rails_helper'

RSpec.describe Question, :type => :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :text }

  it { should ensure_length_of(:title).is_at_least(5).is_at_most(250) }
  it { should ensure_length_of(:text).is_at_least(15) }

  it { should have_many(:answers)}
  it { should have_many(:attachments)}

  it { should belong_to(:user)}

  it { should accept_nested_attributes_for :attachments}

  describe '#has_accepted_answers?' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question)}
    context 'yes' do
      before { answer.accept }
      it 'returns true' do
        expect(question.has_accepted_answers?).to be true
      end
    end
    context 'no' do
      it 'returns false' do
        expect(question.has_accepted_answers?).not_to be true
      end
    end
  end
end

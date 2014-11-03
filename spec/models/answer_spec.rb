require 'rails_helper'

RSpec.describe Answer, :type => :model do
  it { should validate_presence_of :text }
  it { should belong_to(:question)}
  it { should belong_to(:user)}
  it { should have_many(:attachments)}

  it { should accept_nested_attributes_for :attachments}

  it 'should has a scope accepted' do
    answer1 = create(:answer, is_accepted: true)
    answer2 = create(:answer, is_accepted: false)
    expect(Answer.accepted).to eq [answer1]
  end

  describe '#accept' do
    let(:question) {create(:question)}
    context "answer's question has no accepted answers" do
      let!(:answer) { create(:answer, question: question, is_accepted: false)}
      it 'should mark answer as accepted' do
        expect{answer.accept}.to change(answer, :is_accepted).to(true)
      end
      it 'should return true' do
        expect(answer.accept).to eq true
      end
    end
    context "answer's question has another accepted answer" do
      let!(:answer1) {create(:answer, question: question, is_accepted: false)}
      let!(:answer2) {create(:answer, question: question, is_accepted: true)}
      it 'should return false' do
        expect(answer1.accept).to eq false
      end
    end
  end
end
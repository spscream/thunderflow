require 'rails_helper'

describe AnswerPolicy do

  let(:user) { create(:user) }
  let(:answer) { create(:answer) }
  let(:answers) { create_list(:answer, 10) }

  subject { AnswerPolicy }

  permissions :index? do
    it 'grants access for users' do
      expect(subject).to permit(user, answers)
    end

    it 'grants access for guests' do
      expect(subject).to permit(nil, answers)
    end
  end

  permissions :create? do
    it 'grants access for users' do
      expect(subject).to permit(user, answer)
    end

    it 'denies access for guests' do
      expect(subject).to_not permit(nil, answer)
    end
  end

  permissions :show? do
    it 'grants access for users' do
      expect(subject).to permit(user, answer)
    end

    it 'grants access for guests' do
      expect(subject).to permit(nil, answer)
    end
  end

  permissions :update? do
    it 'grants access for answer author' do
      expect(subject).to permit(user, create(:answer, user: user))
    end

    it 'denies access for others' do
      expect(subject).to_not permit(user, answer)
    end
  end

  permissions :destroy? do
    it 'grants access for answer author' do
      expect(subject).to permit(user, create(:answer, user: user))
    end

    it 'denies access for others' do
      expect(subject).to_not permit(user, answer)
    end
  end

  permissions :accept? do
    it 'grants access for answers question author' do
      expect(subject).to permit(user, create(:answer, question: create(:question, user: user)))
    end

    it 'denies access for answers question author' do
      expect(subject).to_not permit(user, create(:answer))
    end
  end
end

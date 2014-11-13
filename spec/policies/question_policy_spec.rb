require 'rails_helper'

describe QuestionPolicy do

  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:questions) { create_list(:question, 10) }

  subject { QuestionPolicy }

  permissions :index? do
    it 'grants access for users' do
      expect(subject).to permit(user, questions)
    end

    it 'grants access for guests' do
      expect(subject).to permit(nil, questions)
    end
  end

  permissions :create? do
    it 'grants access for users' do
      expect(subject).to permit(user, question)
    end

    it 'denies access for guests' do
      expect(subject).to_not permit(nil, question)
    end
  end

  permissions :show? do
    it 'grants access for users' do
      expect(subject).to permit(user, question)
    end

    it 'grants access for guests' do
      expect(subject).to permit(nil, question)
    end
  end

  permissions :update? do
    it 'grants access for question author' do
      expect(subject).to permit(user, create(:question, user: user))
    end

    it 'denies access for others' do
      expect(subject).to_not permit(user, question)
    end
  end

  permissions :destroy? do
    it 'grants access for question author' do
      expect(subject).to permit(user, create(:question, user: user))
    end

    it 'denies access for others' do
      expect(subject).to_not permit(user, question)
    end
  end
end

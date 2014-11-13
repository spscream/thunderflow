require 'rails_helper'

describe CommentPolicy do

  let(:user) { create(:user) }
  let(:comment) { create(:comment)}
  let(:comments) { create_list(:comment, 10)}

  subject { CommentPolicy }

  permissions :index? do
    it 'grants access for users' do
      expect(subject).to permit(user, comments)
    end

    it 'grants access for guests' do
      expect(subject).to permit(nil, comments)
    end
  end

  permissions :create? do
    it 'grants access for users' do
      expect(subject).to permit(user, comment)
    end

    it 'denies access for guests' do
      expect(subject).to_not permit(nil, comment)
    end
  end

  permissions :show? do
    it 'grants access for users' do
      expect(subject).to permit(user, comment)
    end

    it 'grants access for guests' do
      expect(subject).to permit(nil, comment)
    end
  end

  permissions :update? do
    it 'grants access for comment author' do
      expect(subject).to permit(user, create(:comment, user: user))
    end

    it 'denies access for others' do
      expect(subject).to_not permit(user, comment)
    end
  end

  permissions :destroy? do
    it 'grants access for comment author' do
      expect(subject).to permit(user, create(:comment, user: user))
    end

    it 'denies access for others' do
      expect(subject).to_not permit(user, comment)
    end
  end
end

require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:answers) }
  it { should have_many(:questions) }
  it { should have_many(:social_authentications) }

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '12345') }

    context 'user already has authorization' do
      it 'returns the user' do
        user.social_authentications.create(provider: 'facebook', uid: '12345')

        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has no authorization' do
      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '12345', info: {email: user.email}) }
        it 'should not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates social authentication for user' do
          expect { User.find_for_oauth(auth) }.to change(SocialAuthentication, :count).by(1)
        end

        it 'creates social authentication with provider and uid' do
          social_authentication = User.find_for_oauth(auth).social_authentications.first

          expect(social_authentication.provider).to eq auth.provider
          expect(social_authentication.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end
    end

    context 'user does not exist' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '12345', info: { email: 'new@user.com' }) }

      it 'creates new user' do
        expect {User.find_for_oauth(auth) }.to change(User, :count).by(1)
      end

      it 'returns new user' do
        expect(User.find_for_oauth(auth)).to be_a(User)
      end

      it 'fills user email' do
        user = User.find_for_oauth(auth)
        expect(user.email).to eq auth.info.email
      end

      it 'creates social authentication' do
        user = User.find_for_oauth(auth)
        expect(user.social_authentications).to_not be_empty
      end

      it 'creates social authentication with provider and uid' do
        social_authentication = User.find_for_oauth(auth).social_authentications.first

        expect(social_authentication.provider).to eq auth.provider
        expect(social_authentication.uid).to eq auth.uid
      end
    end

    context 'not existing user uses oauth provider without email' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '12345', info: {}) }

      it 'creates new user' do
        expect {User.find_for_oauth(auth) }.to change(User, :count).by(1)
      end

      it 'creates social authentication with provider and uid' do
        social_authentication = User.find_for_oauth(auth).social_authentications.first

        expect(social_authentication.provider).to eq auth.provider
        expect(social_authentication.uid).to eq auth.uid
      end

      it 'fills temporary email for user' do
        user = User.find_for_oauth(auth)

        expect(user.email).to eq "#{User::TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
      end
    end
  end
end
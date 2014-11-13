class SocialAuthentication < ActiveRecord::Base
  belongs_to :user

  def self.find_for_oauth(auth)
    identity = find_by(provider: auth.provider, uid: auth.uid.to_s)
    identity = create(uid: auth.uid.to_s, provider: auth.provider) if identity.nil?
    identity
  end
end

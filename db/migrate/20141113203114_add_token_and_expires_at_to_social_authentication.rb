class AddTokenAndExpiresAtToSocialAuthentication < ActiveRecord::Migration
  def change
    add_column :social_authentications, :token, :string
    add_column :social_authentications, :token_expires_at, :datetime
  end
end

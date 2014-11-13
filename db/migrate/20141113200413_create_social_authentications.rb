class CreateSocialAuthentications < ActiveRecord::Migration
  def change
    create_table :social_authentications do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid
      t.string :raw_info

      t.timestamps
    end
  end
end

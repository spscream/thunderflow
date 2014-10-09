class AddQuestionIdToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :question_id, :string
    add_index :attachments, :question_id
  end
end

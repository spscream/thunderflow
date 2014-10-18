class ChangeAttacmentsToBePolymorphic < ActiveRecord::Migration
  def change
    remove_column :attachments, :question_id
    add_reference :attachments, :attachable, polymorphic: true, index: true
  end
end

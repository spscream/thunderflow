class RenameAcceptedToIsAcceptedForAnswers < ActiveRecord::Migration
  def change
    rename_column :answers, :accepted, :is_accepted
  end
end

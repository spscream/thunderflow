class AddAcceptedAnswerIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :accepted_answer_id, :integer, default: nil
  end
end

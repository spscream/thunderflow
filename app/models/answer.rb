class Answer < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :question

  def accepted?
    self.question.accepted_answer == self
  end
end

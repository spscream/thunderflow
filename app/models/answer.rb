class Answer < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :user
  belongs_to :question
  scope :accepted, -> { where(accepted: true)}

  def accepted?
    self.question.accepted_answer == self
  end
end

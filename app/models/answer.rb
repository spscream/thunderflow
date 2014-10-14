class Answer < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :user
  belongs_to :question
  scope :accepted, -> { where(is_accepted: true)}
  default_scope { order(is_accepted: :desc, created_at: :asc) }

  def accept
    if self.question.answers.accepted.empty?
      self.is_accepted = true
      self.save!
    end
    self.is_accepted
  end
end

class Answer < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :user
  belongs_to :question
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => proc {|attributes| attributes['file'].blank?}
  scope :accepted, -> { where(is_accepted: true)}
  default_scope { order(is_accepted: :desc, created_at: :asc) }

  def accept
    self.question.has_accepted_answers? ? false : update(is_accepted: true)
  end
end

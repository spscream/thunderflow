class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  has_many :attachments, as: :attachable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => proc {|attributes| attributes['file'].blank?}

  scope :accepted, -> { where(is_accepted: true)}
  default_scope { order(is_accepted: :desc, created_at: :asc) }

  validates :text, presence: true

  def accept
    self.question.has_accepted_answers? ? false : self.update(is_accepted: true)
  end
end

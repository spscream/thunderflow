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
    self.update(is_accepted: true)
    is_accepted
  end

  def is_accepted=(is_accepted)
    if is_accepted
      self.question.has_accepted_answers? ? false : write_attribute(:is_accepted, true)
    else
      write_attribute(:is_accepted, false)
    end
  end
end

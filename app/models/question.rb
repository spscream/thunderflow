class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :attachments
  validates :text, presence: true, length: {minimum: 15}
  validates :title, presence: true, length: {in: 5..250}

  accepts_nested_attributes_for :attachments
end

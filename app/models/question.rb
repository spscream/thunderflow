class Question < ActiveRecord::Base
  has_many :answers
  validates :text, presence: true, length: {minimum: 15}
  validates :title, presence: true, length: {in: 5..250}
end

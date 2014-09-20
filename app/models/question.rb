class Question < ActiveRecord::Base
  validates_presence_of :text
  validates_presence_of :title
  validates_length_of :title, in: 5..250
  validates_length_of :text, minimum: 15
  has_many :answers
end

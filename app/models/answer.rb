class Answer < ActiveRecord::Base
  validates_presence_of :text
  belongs_to :question
end

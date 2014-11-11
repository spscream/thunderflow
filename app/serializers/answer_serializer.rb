class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :text, :user, :question_id, :is_accepted,  :created_at, :updated_at
end

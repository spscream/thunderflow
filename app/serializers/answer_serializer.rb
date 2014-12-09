class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :text, :user, :question_id, :is_accepted,  :created_at, :updated_at, :can_edit, :can_delete, :can_accept

  def can_edit
    AnswerPolicy.new(scope, object).update?
  end

  def can_delete
    AnswerPolicy.new(scope, object).destroy?
  end

  def can_accept
    AnswerPolicy.new(scope, object).accept?
  end
end

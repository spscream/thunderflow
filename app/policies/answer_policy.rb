class AnswerPolicy < ApplicationPolicy
  def create?
    !user.nil?
  end

  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end

  def index?
    true
  end

  def accept?
    user == record.question.user
  end
end

class QuestionPolicy < ApplicationPolicy
  attr_reader :user, :question

  def initialize(user, question)
    @user = user
    @question = question
  end

  def index?
    true
  end

  def show?
    user.lawyer? || (user.user? && question.user == user)
  end

  def new?
    create?
  end

  def create?
    user.user?
  end
end

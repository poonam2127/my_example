class LawyersssPolicy < ApplicationPolicy
  attr_reader :user, :question

  def initialize(user, question)
    @user = user
    @question = question
  end

  def index?
    true
  end
end

class BaseController < ApplicationController
  include Pundit::Authorization
  layout 'users'

  before_action :authenticate_user!
  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # def pundit_user
  #   current_user
  # end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_back_or_to(root_path)
  end
end
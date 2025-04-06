class Admin::DashboardController < BaseController
  before_action :authenticate_user! # Make sure the user is logged in
  
  def index
    # Check if the current user is an admin (you might have an admin role for this)
    if current_user.admin?
      # Fetch data for the dashboard
      @paid_answer = Answer.paid
      @paid_answers_count = @paid_answer.count
      @simulated_revenue = @paid_answer.sum(:proposed_fee)
      @open_que_count = Question.open.count
    else
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end
end

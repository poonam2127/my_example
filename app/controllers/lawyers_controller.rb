class LawyersController < BaseController
  def index
    @lawyer_questions = Question.open
    authorize(@lawyer_questions)
  end
end

class QuestionsController < BaseController
  def index
    if current_user&.lawyer?
      redirect_to lawyer_path
    elsif current_user&.admin?
      redirect_to admin_dashboard_path
    else
      @questions = current_user.questions
      authorize(@questions)
    end
  end

  def show
    @question = Question.find(params[:id])
    authorize(@question)
  end

  def new
    @question = current_user.questions.build

    authorize(@question)
  end

  def create
    @question = current_user.questions.build(question_params)
    authorize(@question)

    if @question.save
      redirect_to @question
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :category)
  end
end

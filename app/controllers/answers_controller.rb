class AnswersController < BaseController
  def create
    @question = Question.open.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    authorize(@answer)

    if @answer.save
      # Simulate payment request
      Rails.logger.info "Simulated payment request sent to #{@question.user.email} for £#{@answer.proposed_fee}"
      puts "Simulated email: 'Hi #{@question.user.name}, a lawyer has answered your question. Approve payment to see it!'"

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("answers_#{@question.id}", partial: "answers/list", locals: { question: @question })
        end
        format.html { redirect_to @question, notice: "Answer submitted and payment request sent." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def approve_payment
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])

    if current_user == @question.user
      @answer.update(paid: true)
      @question.update(status: "answered") if @question.status == "open"

      Rails.logger.info "User #{@question.user.email} approved payment of £#{@answer.proposed_fee} for answer ##{@answer.id}"
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("answers_#{@question.id}", partial: "answers/list", locals: { question: @question })
      end
      format.html { redirect_to @question, notice: "Payment approved. You can now view the answer." }
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:response_text, :proposed_fee)
  end
end

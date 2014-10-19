class AnswersController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :load_answer, only: [:update, :accept]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answers = @question.answers.all
    if @answer.save
      flash[:notice] = 'Answer successfully created.'
    else
      render 'questions/show'
    end
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def accept
    if @answer.accept
      @question = @answer.question
      @answers = @question.answers.all
      flash[:notice] = 'You accepted an answer.'
    else
      render :status => :forbidden, :text => 'Question already has accepted answer.'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy!
    flash[:notice] = 'Answer was successfully deleted'
  end

  private
  def answer_params
    params.require(:answer).permit(:question_id, :text, :user_id, attachments_attributes: [:file, :_destroy, :file_cache])
  end

  def load_answer
    @answer = current_user.answers.find(params[:id])
  end
end

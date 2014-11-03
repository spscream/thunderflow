class AnswersController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :load_answer, only: [:update, :accept, :destroy]
  before_action :load_question, only: [:create]

  respond_to :json, :js

  def create
    respond_with @answer = @question.answers.create(answer_params.merge(user_id: current_user.id))
  end

  def update
    @answer.update(answer_params)
    respond_with @answer
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
    respond_with(@answer.destroy)
  end

  private
  def answer_params
    params.require(:answer).permit(:question_id, :text, :user_id, attachments_attributes: [:file, :_destroy, :file_cache, :id])
  end

  def load_answer
    @answer = current_user.answers.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end

class AnswersController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :load_and_authorize_answer, only: [:update, :accept, :destroy]
  after_action :publish_answer, only: [:create, :update]

  respond_to :json, :js

  def index
    @question = Question.find(params[:question_id])
    respond_with(@answers = @question.answers)
  end

  def create
    @question = Question.find(params[:question_id])
    authorize @answer = @question.answers.create(answer_params.merge(user_id: current_user.id))
    respond_with(@answer)
  end

  def edit

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
  def publish_answer
    PrivatePub.publish_to("/questions/#{@answer.question.id}/answers", AnswerSerializer.new(@answer)) if @answer.valid?
  end

  def load_and_authorize_answer
    @answer = current_user.answers.find(params[:id])
    authorize(@answer)
  end

  def answer_params
    params.require(:answer).permit(:question_id, :text, :user_id, attachments_attributes: [:file, :_destroy, :file_cache, :id])
  end
end

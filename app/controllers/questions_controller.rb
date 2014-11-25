class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_and_authorize_question, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :js, only: [:destroy]

  def index
    authorize @questions = Question.all
    respond_with(@questions)
  end

  def show
    respond_with @question
  end

  def new
    authorize @question = Question.new
    respond_with(@question)
  end

  def edit
    respond_with(@question)
  end

  def create
    respond_with(@question = current_user.questions.create(question_params))
  end

  def update
    if @question.update(question_params)
      respond_with @question, location: question_path(@question)
    else
      render 'questions/edit'
    end
  end

  def destroy
    respond_with(@question.destroy)
  end

  private

  def question_params
    params.require(:question).permit(:title, :text, attachments_attributes: [:file, :_destroy, :file_cache, :id])
  end

  def load_and_authorize_question
    @question = Question.find(params[:id])
    authorize @question
  end
end

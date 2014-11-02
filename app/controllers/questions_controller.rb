class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :js, only: [:destroy]

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit
    if current_user != @question.user
      flash[:error] = 'You cannot edit question. You are not an owner.'
      redirect_to question_path(@question)
    else
      respond_with(@question)
    end
  end

  def create
    respond_with(@question = current_user.questions.create(question_params))
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    respond_with(@question.destroy)
  end

  private

  def question_params
    params.require(:question).permit(:title, :text, attachments_attributes: [:file, :_destroy, :file_cache, :id])
  end

  def load_question
    @question = Question.find(params[:id])
  end
end

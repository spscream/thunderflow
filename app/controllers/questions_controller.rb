class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
    @answers = @question.answers.all.order(is_accepted: :desc)
  end

  def new
    @question = Question.new
  end

  def edit
    if current_user != @question.user
      flash[:error] = 'You cannot edit question. You are not an owner.'
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      flash[:notice] = 'Question was successfully updated.'
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :text)
  end

  def load_question
    @question = Question.find(params[:id])
  end
end

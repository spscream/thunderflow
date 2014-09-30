class AnswersController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answers = @question.answers.all.order(is_accepted: :desc, created_at: :asc)
    if @answer.save
      flash[:notice] = "Answer successfully created."
    else
      render 'questions/show'
    end
  end

  def accept
    @answer = Answer.find(params[:id])
    if current_user != @answer.question.user
      render :status => :forbidden, :text => 'You are not an owner of question.'
    else
      @question = @answer.question
      if @question.answers.accepted.empty?
        @answer.is_accepted = true
        if @answer.save!
          flash[:notice] = "You accepted an answer."
          @answers = @question.answers.all.order(is_accepted: :desc, created_at: :asc)
          render 'answers/accept'
        end
      else
        render :status => :forbidden, :text => 'Question already has accepted answer.'
      end
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:question_id, :text)
  end
end

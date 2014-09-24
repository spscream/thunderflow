class AnswersController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save
      flash[:notice] = "Answer successfully created."
    else
      render 'questions/show'
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:question_id, :text)
  end
end

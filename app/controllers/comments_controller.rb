class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parent

  respond_to :js

  def create
    authorize @comment = @parent.comments.create(comment_params.merge(user: current_user))
    respond_with(@comment)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def load_parent
    @parent = Question.find(params[:question_id]) if params[:question_id]
    @parent ||= Answer.find(params[:answer_id])
  end
end
class PersonalCommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.group_id = nil unless params[:comment][:group_id].present?
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(summary_id: params[:personal_summary_id])
  end
end

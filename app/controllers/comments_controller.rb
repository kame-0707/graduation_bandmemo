# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @comment = current_user.comments.new(comment_params)
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(group_id: params[:group_id], summary_id: params[:summary_id])
  end
end

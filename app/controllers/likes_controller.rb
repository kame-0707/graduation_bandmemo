# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    Like.create(user_id: current_user.id, group_id: params[:group_id], summary_id: params[:summary_id])
    redirect_to group_summaries_path(@group)
  end

  def destroy
    @group = Group.find(params[:group_id])
    like = current_user.likes.find_by(group_id: params[:group_id], summary_id: params[:summary_id])
    like.destroy!
    redirect_to group_summaries_path(@group), status: :see_other
  end
end

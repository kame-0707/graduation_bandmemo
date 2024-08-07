class PersonalLikesController < ApplicationController
  def create
    Like.create(user_id: current_user.id, summary_id: params[:personal_summary_id])
    redirect_to personal_summaries_path
  end

  def destroy
    like = current_user.likes.find_by(summary_id: params[:personal_summary_id])
    like.destroy!
    redirect_to personal_summaries_path, status: :see_other
  end
end

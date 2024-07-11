class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: 'プロフィールを更新しました'
    else
      flash.now[:danger] = 'プロフィールを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    user = @user
    user.destroy!
    redirect_to root_path, status: :see_other, alert: 'ユーザーが削除されました'
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name)
  end
end

# frozen_string_literal: true

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

  def destroy
    if current_user.groups.exists?(owner_id: current_user.id)
      redirect_to profile_path, alert: '自分がオーナーのグループがあります。ユーザー削除をするためには、バンドメンバーに確認の上、自分がオーナーのグループを全て削除してから実行してください。'
    else
      user = @user
      user.destroy!
      redirect_to root_path, status: :see_other, alert: 'ユーザーが削除されました'
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name)
  end
end

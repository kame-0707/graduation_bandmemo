# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: %i[edit update destroy permits]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @owner = User.find(@group.owner_id)
  end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)
    # 誰が作ったグループかを判断するため
    @group.owner_id = current_user.id
    if @group.save
      GroupUser.create(user_id: current_user.id, group_id: @group.id)
      redirect_to groups_path, notice: t('groups.create.success')
    else
      flash.now[:alert] = t('groups.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: t('groups.update.success')
    else
      flash.now[:alert] = t('groups.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    group = @group
    group.destroy!
    redirect_to groups_path, status: :see_other, notice: t('groups.destroy.deleted')
  end

  def permits
    @group = Group.find(params[:id])
    @permits = @group.permits.page(params[:page])
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

  # params[:id]を持つ@groupの、owner_idと自分のユーザーIDが一致しているかどうかを確認
  # 違う場合、グループ一覧ページへ遷移させる。
  def ensure_correct_user
    @group = Group.find(params[:id])
    return if @group.owner_id == current_user.id

    redirect_to group_path(@group), alert: t('groups.alert.owner_authority')
  end
end

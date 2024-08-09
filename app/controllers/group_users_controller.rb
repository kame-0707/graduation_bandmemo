# frozen_string_literal: true

class GroupUsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @permit = Permit.find(params[:permit_id])
    @group_user = GroupUser.create(user_id: @permit.user_id, group_id: params[:group_id])
    @permit.destroy
    redirect_to request.referer, notice: 'グループに加入しました'
  end

  def destroy
    # 自分のuser_id+脱退したいグループのIDを持ったgroup_userをテーブルから取得し、削除
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy!
    redirect_to request.referer, notice: 'グループを退出しました'
  end
end

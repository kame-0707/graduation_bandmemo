class GroupUsersController < ApplicationController
  def create
    # 自分のuser_id+加入するグループのIDを持ったgroup_userを作成し、保存
    group_user = current_user.group_users.build(group_id: params[:group_id])
    group_user.save
    redirect_to request.referer, notice: 'グループに加入しました'
  end

  def destroy
    # 自分のuser_id+加入するグループのIDを持ったgroup_userをテーブルから取得し、削除
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy!
    redirect_to request.referer, status: :see_other, notice: 'グループを脱退しました'
  end
end

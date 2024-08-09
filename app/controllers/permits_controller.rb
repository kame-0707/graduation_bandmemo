# frozen_string_literal: true

class PermitsController < ApplicationController
  def create
    # 加入申請中ユーザーの一覧を表示するために変数を作成
    @group = Group.find(params[:group_id])
    # 自分のuser_id+加入申請するグループのIDを持ったpermitを作成し、保存
    permit = current_user.permits.new(group_id: params[:group_id])
    permit.save
    redirect_to request.referer, notice: 'グループへ参加申請しました'
  end

  def destroy
    # 自分のuser_id+加入申請を削除したいグループのIDを持ったpermitをテーブルから取得し、削除
    permit = current_user.permits.find_by(group_id: params[:group_id])
    permit.destroy
    redirect_to request.referer, alert: 'グループへの参加申請を取消しました'
  end
end

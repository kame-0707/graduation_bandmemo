class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.build(group_params)
    # 誰が作ったグループかを判断するため
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, notice: 'グループが作成されました'
    else
      flash.now[:alert] = 'グループを作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: 'グループが更新されました'
    else
      flash.now[:alert] = 'グループを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    group = @group
    group.destroy!
    redirect_to groups_path, status: :see_other, notice: 'グループが削除されました'
  end


  private

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

  # params[:id]を持つ@groupの、owner_idと自分のユーザーIDが一致しているかどうかを確認
  # 違う場合、グループ一覧ページへ遷移させる。
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end

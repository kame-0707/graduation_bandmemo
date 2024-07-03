class VoicesController < ApplicationController
  before_action :set_voice, only: %i[edit update destroy]
  before_action :set_group
  before_action :authorize_user!
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def index
    @voices = @group.voices.order(created_at: :desc)
  end

  def show
    @voice = @group.voices.find(params[:id])
  end

  def create
    @voice = @group.voices.new(content: voice_params[:content], user: current_user)
    if @voice.save
      respond_to do |format|
        format.json { render json: { message: 'Voice saved successfully' }, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @voice.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    if @voice.update(voice_params)
      redirect_to group_voices_path(@group, @voice), notice: '音声メモが更新されました'
    else
      flash.now[:alert] = '音声メモを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    voice = @voice
    voice.destroy!
    redirect_to group_voices_path(@group), status: :see_other, notice: '音声メモが削除されました'
  end

  private

  def set_voice
    @group = Group.find(params[:group_id])
    @voice = @group.voices.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def authorize_user!
    @group = Group.find(params[:group_id])
    unless current_user.groups.include?(@group)
      redirect_to root_path, alert: 'グループメンバーとして承認されていません'
    end
  end

  def authorize_owner!
    @voice = @group.voices.find(params[:id])
    @group = Group.find(params[:group_id])
    unless @voice.user == current_user
      redirect_to group_voices_path(@group), alert: '編集・削除ができるのは投稿者のみです'
    end
  end

  def voice_params
    params.require(:voice).permit(:content)
  end
end

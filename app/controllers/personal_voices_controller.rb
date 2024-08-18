# frozen_string_literal: true

class PersonalVoicesController < ApplicationController
  before_action :set_voice, only: %i[edit update destroy]

  def index
    @voices = current_user.voices.where(group_id: nil).order(created_at: :desc)
  end

  def show
    @voice = current_user.voices.where(group_id: nil).find(params[:id])
  end

  def edit; end

  def create
    @voice = current_user.voices.new(content: voice_params[:content])
    @voice.group_id = nil if params[:voice][:group_id].blank?
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

  def update
    if @voice.update(voice_params)
      redirect_to personal_voices_path(@voice), notice: '音声メモが更新されました'
    else
      flash.now[:alert] = '音声メモを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    voice = @voice
    voice.destroy!
    redirect_to personal_voices_path, status: :see_other, notice: '音声メモが削除されました'
  end

  private

  def set_voice
    @voice = current_user.voices.where(group_id: nil).find(params[:id])
  end

  def voice_params
    params.require(:voice).permit(:content)
  end
end

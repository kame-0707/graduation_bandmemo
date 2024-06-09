class VoicesController < ApplicationController

  def index
    @voices = Voice.all
  end

  def create
    @voice = Voice.new(voice_params)
    if @voice.save
      render json: { message: 'Voice saved successfully' }, status: :created
      # redirect_to voices_path, notice: '音声メモが更新されました'
    else
      render json: { errors: @voice.errors.full_messages }, status: :unprocessable_entity
      # flash.now[:alert] = '音声メモを更新できませんでした'
      # render :index, status: :unprocessable_entity
    end
  end

  private

  def voice_params
    params.require(:voice).permit(:content)
  end
end

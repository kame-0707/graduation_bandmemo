# frozen_string_literal: true

class PersonalSpotsController < ApplicationController
  before_action :set_spot, only: %i[edit update destroy]

  def index
    @spots = current_user.spots.where(group_id: nil).order(start_datetime: :asc)
  end

  def show
    @spot = current_user.spots.where(group_id: nil).find(params[:id])
  end

  def new
    @spot = current_user.spots.new
  end

  def edit; end

  def create
    @spot = current_user.spots.new(spot_params)
    @spot.group_id = nil if params[:spot][:group_id].blank?
    if @spot.save
      redirect_to personal_spots_path, notice: 'スタジオが登録されました'
    else
      flash.now[:alert] = 'スタジオを登録できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @spot.update(spot_params)
      redirect_to group_spots_path(@spot), notice: 'スタジオが更新されました'
    else
      flash.now[:alert] = 'スタジオを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    spot = @spot
    spot.destroy!
    redirect_to personal_spots_path, status: :see_other, notice: 'スタジオが削除されました'
  end

  private

  def set_spot
    @spot = current_user.spots.where(group_id: nil).find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:registered_title, :start_datetime, :address, :lat, :lng, :opening_hours,
                                 :phone_number, :website, :place_id)
  end
end

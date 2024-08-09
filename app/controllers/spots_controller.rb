# frozen_string_literal: true

class SpotsController < ApplicationController
  before_action :set_spot, only: %i[edit update destroy]
  before_action :set_group
  before_action :authorize_user!
  before_action :authorize_owner!, only: %i[show edit update destroy]

  def index
    @spots = @group.spots.order(start_datetime: :asc)
  end

  def show
    @spot = @group.spots.find(params[:id])
  end

  def new
    @spot = @group.spots.new
  end

  def edit; end

  def create
    @spot = @group.spots.new(spot_params.merge(user: current_user))
    if @spot.save
      redirect_to group_spots_path(@group), notice: 'スタジオが登録されました'
    else
      flash.now[:alert] = 'スタジオを登録できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @spot.update(spot_params)
      redirect_to group_spots_path(@group, @spot), notice: '音声メモが更新されました'
    else
      flash.now[:alert] = '音声メモを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    spot = @spot
    spot.destroy!
    redirect_to group_spots_path(@group), status: :see_other, notice: '音声メモが削除されました'
  end

  private

  def set_spot
    @group = Group.find(params[:group_id])
    @spot = @group.spots.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def authorize_user!
    @group = Group.find(params[:group_id])
    return if current_user.groups.include?(@group)

    redirect_to root_path, alert: 'グループメンバーとして承認されていません'
  end

  def authorize_owner!
    @spot = @group.spots.find(params[:id])
    @group = Group.find(params[:group_id])
    return if @spot.user == current_user

    redirect_to group_voices_path(@group), alert: '操作の権限がありません'
  end

  def spot_params
    params.require(:spot).permit(:registered_title, :start_datetime, :address, :lat, :lng, :opening_hours,
                                 :phone_number, :website, :place_id)
  end
end

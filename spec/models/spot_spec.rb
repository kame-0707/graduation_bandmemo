# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spot, type: :model do
  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      spot = build(:spot)
      expect(spot).to be_valid
    end
  end

  context '緯度が存在しない場合' do
    it '無効であること' do
      spot = build(:spot, lat: nil)
      expect(spot).to be_invalid
      expect(spot.errors[:lat]).to include('を入力してください')
    end
  end

  context '経度が存在しない場合' do
    it '無効であること' do
      spot = build(:spot, lng: nil)
      expect(spot).to be_invalid
      expect(spot.errors[:lng]).to include('を入力してください')
    end
  end

  context 'タイトルが存在しない場合' do
    it '無効であること' do
      spot = build(:spot, registered_title: nil)
      expect(spot).to be_invalid
      expect(spot.errors[:registered_title]).to include('を入力してください')
    end
  end

  context '練習開始日時が存在しない場合' do
    it '無効であること' do
      spot = build(:spot, start_datetime: nil)
      expect(spot).to be_invalid
      expect(spot.errors[:start_datetime]).to include('を入力してください')
    end
  end

  context 'タイトルが255文字以下の場合' do
    it '有効であること' do
      spot = build(:spot, registered_title: 'a' * 255)
      expect(spot).to be_valid
    end
  end

  context 'タイトルが256文字以上の場合' do
    it '無効であること' do
      spot = build(:spot, registered_title: 'a' * 256)
      expect(spot).to be_invalid
      expect(spot.errors[:registered_title]).to include('は255文字以内で入力してください')
    end
  end
end

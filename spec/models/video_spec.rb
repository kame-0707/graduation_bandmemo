# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      video = build(:video)
      expect(video).to be_valid
    end
  end

  context 'タイトルが存在しない場合' do
    it '無効であること' do
      video = build(:video, title: nil)
      expect(video).to be_invalid
      expect(video.errors[:title]).to include('を入力してください')
    end
  end

  context 'タイトルが255文字以下の場合' do
    it '有効であること' do
      video = build(:video, title: 'a' * 255)
      expect(video).to be_valid
    end
  end

  context 'タイトルが256文字以上の場合' do
    it '無効であること' do
      video = build(:video, title: 'a' * 256)
      expect(video).to be_invalid
      expect(video.errors[:title]).to include('は255文字以内で入力してください')
    end
  end

  context '動画URLが存在しない場合' do
    it '無効であること' do
      video = build(:video, videos_url: nil)
      expect(video).to be_invalid
      expect(video.errors[:videos_url]).to include('を入力してください')
    end
  end

  context '動画URLが255文字以下の場合' do
    it '有効であること' do
      video = build(:video, videos_url: 'a' * 255)
      expect(video).to be_valid
    end
  end

  context '動画URLが256文字以上の場合' do
    it '無効であること' do
      video = build(:video, videos_url: 'a' * 256)
      expect(video).to be_invalid
      expect(video.errors[:videos_url]).to include('は255文字以内で入力してください')
    end
  end
end

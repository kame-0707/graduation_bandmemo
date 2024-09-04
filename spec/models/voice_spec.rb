require 'rails_helper'

RSpec.describe Voice, type: :model do

  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      voice = build(:voice)
      expect(voice).to be_valid
    end
  end

  context '音声が存在しない場合' do
    it '無効であること' do
      voice = build(:voice, content: nil)
      expect(voice).to be_invalid
      expect(voice.errors[:content]).to include('を入力してください')
    end
  end

  context '音声が65535文字以下の場合' do
    it '有効であること' do
      voice = build(:voice, content: 'a' * 65535)
      expect(voice).to be_valid
    end
  end

  context '音声が65536文字以上の場合' do
    it '無効であること' do
      voice = build(:voice, content: 'a' * 65536)
      expect(voice).to be_invalid
      expect(voice.errors[:content]).to include('は65535文字以内で入力してください')
    end
  end
end

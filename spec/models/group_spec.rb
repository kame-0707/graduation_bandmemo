require 'rails_helper'

RSpec.describe Group, type: :model do
  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      group = build(:group)
      expect(group).to be_valid
    end
  end

  context 'グループ名が存在しない場合' do
    it '無効であること' do
      group = build(:group, name: nil)
      expect(group).to be_invalid
      expect(group.errors[:name]).to include('を入力してください')
    end
  end

  context '紹介文が存在しない場合' do
    it '無効であること' do
      group = build(:group, introduction: nil)
      expect(group).to be_invalid
      expect(group.errors[:introduction]).to include('を入力してください')
    end
  end

  context 'グループ名が255文字以下の場合' do
    it '有効であること' do
      group = build(:group, name: 'a' * 255)
      expect(group).to be_valid
    end
  end

  context 'グループ名が256文字以上の場合' do
    it '無効であること' do
      group = build(:group, name: 'a' * 256)
      expect(group).to be_invalid
      expect(group.errors[:name]).to include('は255文字以内で入力してください')
    end
  end

  context '紹介文が255文字以下の場合' do
    it '有効であること' do
      group = build(:group, introduction: 'a' * 255)
      expect(group).to be_valid
    end
  end

  context '紹介文が256文字以上の場合' do
    it '無効であること' do
      group = build(:group, introduction: 'a' * 256)
      expect(group).to be_invalid
      expect(group.errors[:introduction]).to include('は255文字以内で入力してください')
    end
  end
end

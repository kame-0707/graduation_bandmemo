require 'rails_helper'

RSpec.describe Comment, type: :model do

  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end

  context 'コメントが存在しない場合' do
    it '無効であること' do
      comment = build(:comment, content: nil)
      expect(comment).to be_invalid
      expect(comment.errors[:content]).to include('を入力してください')
    end
  end

  context 'コメントが255文字以下の場合' do
    it '有効であること' do
      comment = build(:comment, content: 'a' * 255)
      expect(comment).to be_valid
    end
  end

  context 'コメントが256文字以上の場合' do
    it '無効であること' do
      comment = build(:comment, content: 'a' * 256)
      expect(comment).to be_invalid
      expect(comment.errors[:content]).to include('は255文字以内で入力してください')
    end
  end
end

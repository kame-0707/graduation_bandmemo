# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Summary, type: :model do
  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      summary = build(:summary)
      expect(summary).to be_valid
    end
  end

  context 'タイトルが存在しない場合' do
    it '無効であること' do
      summary = build(:summary, title: nil)
      expect(summary).to be_invalid
      expect(summary.errors[:title]).to include('を入力してください')
    end
  end

  context '本文が存在しない場合' do
    it '無効であること' do
      summary = build(:summary, content: nil)
      expect(summary).to be_invalid
      expect(summary.errors[:content]).to include('を入力してください')
    end
  end

  context 'タイトルが255文字以下の場合' do
    it '有効であること' do
      summary = build(:summary, title: 'a' * 255)
      expect(summary).to be_valid
    end
  end

  context 'タイトルが256文字以上の場合' do
    it '無効であること' do
      summary = build(:summary, title: 'a' * 256)
      expect(summary).to be_invalid
      expect(summary.errors[:title]).to include('は255文字以内で入力してください')
    end
  end

  context '本文が65535文字以内の場合' do
    it '有効であること' do
      summary = build(:summary, content: 'a' * 65_535)
      expect(summary).to be_valid
    end
  end

  context '本文が65536文字以上の場合' do
    it '無効であること' do
      summary = build(:summary, content: 'a' * 65_536)
      expect(summary).to be_invalid
      expect(summary.errors[:content]).to include('は65535文字以内で入力してください')
    end
  end
end

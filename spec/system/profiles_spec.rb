# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'プロフィール', type: :system do
  let(:user) { create(:user) }
  before { login_as(user) }

  it 'プロフィールの詳細が見られること' do
    visit root_path
    find_by_id('header-profile').click
    click_on 'プロフィール'
    Capybara.assert_current_path('/profile', ignore_query: true)
    expect(current_path).to eq(profile_path), 'プロフィールページに遷移していません'
    expect(page).to have_content(user.name), 'プロフィールページに名前が表示されていません'
  end

  it 'プロフィールの編集ができること' do
    visit profile_path
    click_on '編集'
    Capybara.assert_current_path('/profile/edit', ignore_query: true)
    expect(current_path).to eq(edit_profile_path), 'プロフィール編集ページに遷移していません'
    fill_in 'メールアドレス', with: 'edit@example.com'
    fill_in '名前', with: '編集後名'
    click_button '更新する'
    Capybara.assert_current_path('/profile', ignore_query: true)
    expect(current_path).to eq(profile_path), 'プロフィールページに遷移していません'
    expect(page).to have_content('ユーザーを更新しました'), 'フラッシュメッセージ「ユーザーを更新しました」が表示されていません'
    expect(page).to have_content('編集後名'), '更新後の名前が表示されていません'
  end

  it 'プロフィールの編集に失敗すること' do
    visit profile_path
    click_on '編集'
    Capybara.assert_current_path('/profile/edit', ignore_query: true)
    expect(current_path).to eq(edit_profile_path), 'プロフィール編集ページに遷移していません'
    fill_in '名', with: ''
    click_button '更新する'
    expect(page).to have_content('ユーザーを更新出来ませんでした'), 'フラッシュメッセージ「ユーザーを更新出来ませんでした」が表示されていません'
    expect(page).to have_content('名前を入力してください'), 'エラーメッセージ「名前を入力してください」が表示されていません'
  end
end

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    # ログインしていなかった場合は、topページに遷移させる
    redirect_to root_path, alert: 'ログインが必要です'
  end
end

class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    # topページに遷移する形に変更
    # redirect_to login_path
    redirect_to root_path, alert: 'ログインが必要です'
  end
end

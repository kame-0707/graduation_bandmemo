# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email,
         subject: '【bandmemo】パスワード再発行のご案内')
  end
end

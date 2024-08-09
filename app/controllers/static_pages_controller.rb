class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top service policy]

  def top; end
  def service; end
  def policy; end
end

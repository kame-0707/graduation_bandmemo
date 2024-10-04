class TriesController < ApplicationController
  skip_before_action :require_login

  def spot; end
  def voice; end
  def summary_new; end
  def summary_index; end
  def video; end
end

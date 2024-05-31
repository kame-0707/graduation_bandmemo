class ContentsController < ApplicationController
  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      summary = ::OpenaiService.new.summarize(@content.original)
      if summary
        @content.update(summary: summary)
        redirect_to contents_path, notice: 'コンテンツが要約されて投稿されました。'
      else
        redirect_to new_content_path, alert: 'コンテンツの要約に失敗しました。'
      end
    else
      render :new
    end
  end

  def index
    @contents = Content.all
  end

  private

  def content_params
    params.require(:content).permit(:original)
  end
end

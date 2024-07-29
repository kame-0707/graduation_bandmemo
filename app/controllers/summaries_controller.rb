require "openai"

class SummariesController < ApplicationController
  before_action :set_summary, only: %i[edit update destroy]
  before_action :set_group
  before_action :authorize_user!
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def index
    @summaries = @group.summaries.includes(:user).order(created_at: :desc)
  end

  
  def show
    @summary = @group.summaries.find(params[:id])
    @comment = Comment.new
    @comments = @summary.comments.includes(:user).order(created_at: :desc)
  end
  
  
  def original
    @summary = @group.summaries.find(params[:id])
    unless (@summary.user_id == current_user.id)
      redirect_to group_summaries_path(@group), alert: '原文を確認できるのは投稿者のみです'
    end
  end

  def new
    @summary = @group.summaries.new
  end

  def create
    client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])

    input_content = summary_params[:content]

    if params[:commit] == "AI要約して保存"
      # 入力内容が10文字以下の場合はそのまま出力
      if input_content.length < 10
        summary_text = input_content
      else
      response = client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [
            { role: "system",
            content: 
            "あなたは、入力された情報を厳密に要約するAIアシスタントです。以下の条件に従って、要約を行ってください：
            1. 入力された内容を厳密に要約すること。
            2. 書いてない情報は絶対追加しないこと（質問や推測、対策案、メリット、注意点なども一切追加しない）。
            3. #{input_content}の内容を、必ず・を用いた箇条書きで簡潔にまとめること(例: ・内容1)。
            4. ・を用いた1つの箇条書きには、1つの情報のみを入れること。
            5. 小見出しは必ず番号付きで、番号と小見出し全体を**で囲んで太字にすること（例: **1. 小見出し**）。
            6. 小見出しの数が少なすぎないように注意すること。
            7. 各小見出しの直後には、必ず改行を入れること
            8. ・を用いた箇条書き同士の間には、必ず改行を入れること
            9. 各小見出しでまとめられた項目の直後には、必ず改行を入れること。
            10. 各行の間には、必ず空行は作らない。
            "
          },
            { role: "user",
            content:
              "以下の内容を要約してください。
              #{input_content}"
            },
          ],
        })
      summary_text = response.dig("choices", 0, "message", "content")
      end

      @summary = @group.summaries.new(title: summary_params[:title], content: summary_params[:content], summary: summary_text, user: current_user)
      if @summary.save
        redirect_to group_summaries_path(@group), notice: 'メモが保存されました'
      else
        flash.now[:alert] = 'メモの保存ができませんでした'
        render :new, status: :unprocessable_entity
      end

    elsif params[:commit] == "入力内容をそのまま保存"
      @summary = @group.summaries.new(
        title: summary_params[:title],
        content: input_content,
        summary: nil,
        user: current_user
      )
      if @summary.save
        redirect_to group_summaries_path(@group), notice: 'メモが保存されました'
      else
        flash.now[:alert] = 'メモの保存ができませんでした'
        render :new, status: :unprocessable_entity
      end
    end
  end


  def edit; end

  def update
    if @summary.update(summary_params)
      redirect_to group_summaries_path(@group, @summary), notice: 'メモが更新されました'
    else
      flash.now[:alert] = 'メモを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    summary = @summary
    summary.destroy!
    redirect_to group_summaries_path(@group), status: :see_other, notice: 'メモが削除されました'
  end

  private

  def set_summary
    @group = Group.find(params[:group_id])
    @summary = @group.summaries.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def authorize_user!
    @group = Group.find(params[:group_id])
    unless current_user.groups.include?(@group)
      redirect_to root_path, alert: 'グループメンバーとして承認されていません'
    end
  end

  def authorize_owner!
    @summary = @group.summaries.find(params[:id])
    @group = Group.find(params[:group_id])
    unless (@summary.user_id == current_user.id) || (@group.owner_id == current_user.id)
      redirect_to group_summaries_path(@group), alert: '編集・削除ができるのは投稿者とオーナーのみです'
    end
  end

  def summary_params
    params.require(:summary).permit(:content, :summary, :title)
  end
end

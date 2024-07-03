require "openai"

class SummariesController < ApplicationController
  before_action :set_summary, only: %i[edit update destroy]
  before_action :set_group
  before_action :authorize_user!
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def index
    @summaries = @group.summaries.order(created_at: :desc)
  end

  def show
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

    response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: [
                { role: "system",
                content: "私はバンドでリーダーをしています。
                あなたには私の立場に立って、言葉を要約してメンバーに伝えて欲しいです。
                バンドメンバーに決定事項を簡潔に伝達するための手助けをしてください。"
              },
                { role: "user",
                content: "以下のコンテンツを、マークダウンでわかりやすくまとめてください。#{summary_params[:content]}
                小見出しは必ず番号付きで、番号と小見出し全体を**で囲んで太字にしてください（例：**1. 小見出し**）。
                小見出しの数が少なすぎないように注意し、内容は箇条書きで簡潔にまとめてください。"
              },
            ],
        })
    # response：ハッシュオブジェクト。OpenAI APIからのレスポンスを格納
    # dig：Rubyの標準メソッドで、ハッシュや配列のネストされた構造から値を安全に取得するために使用。存在しないキーを参照した場合でも、エラーを発生させずにnilを返す。
    # "choices"キーにアクセスして、配列を取得。
    # 0番目の要素にアクセス。
    # "message"キーにアクセスして、ハッシュを取得。
    # "content"キーにアクセスして、その値である "要約されたテキスト" を取得。
    summary_text = response.dig("choices", 0, "message", "content")

    @summary = @group.summaries.new(title: summary_params[:title], content: summary_params[:content], summary: summary_text, user: current_user)

    if @summary.save
      redirect_to group_summaries_path(@group), notice: 'メモが保存されました'
    else
      flash.now[:alert] = 'メモの保存ができませんでした'
      render :new, status: :unprocessable_entity
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

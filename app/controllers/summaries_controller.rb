require "openai"

class SummariesController < ApplicationController
  before_action :set_summary, only: %i[edit update destroy]

  def index
    @summaries = current_user.summaries.order(created_at: :desc)
  end

  def show
    @summary = current_user.summaries.find(params[:id])
  end

  def new
    @summary = Summary.new
  end

  def create
    client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])

    response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: [
                { role: "system", content: "私はバンドでリーダーをしています。あなたには私の立場に立って、言葉を要約してメンバーに伝えて欲しいです。バンドメンバーに決定事項を簡潔に伝達するための手助けをしてください。" },
                { role: "user", content: "以下のコンテンツを、マークダウンでわかりやすくまとめてください。小見出しは必ず番号付きで、番号と小見出しを必ず**で囲んで太字にしてください。小見出しの数が少なすぎないように注意し、内容は箇条書きで簡潔にまとめてください。#{summary_params[:content]}" },
            ],
        })
    # response：ハッシュオブジェクト。OpenAI APIからのレスポンスを格納
    # dig：Rubyの標準メソッドで、ハッシュや配列のネストされた構造から値を安全に取得するために使用します。存在しないキーを参照した場合でも、エラーを発生させずにnilを返します。
    # "choices"キーにアクセスして、配列を取得。
    # 0番目の要素にアクセス。
    # "message"キーにアクセスして、ハッシュを取得。
    # "content"キーにアクセスして、その値である "要約されたテキスト" を取得。
    summary_text = response.dig("choices", 0, "message", "content")

    @summary = current_user.summaries.build(title: summary_params[:title], content: summary_params[:content], summary: summary_text)

    if @summary.save
      redirect_to summaries_path, notice: 'メモが保存されました'
    else
      flash.now[:alert] = 'メモの保存ができませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @summary.update(summary_params)
      redirect_to summaries_path, notice: 'メモが更新されました'
    else
      flash.now[:alert] = 'メモを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    summary = @summary
    summary.destroy!
    redirect_to summaries_path, status: :see_other, notice: 'メモが削除されました'
  end

  private

  def set_summary
    @summary = current_user.summaries.find(params[:id])
  end

  def summary_params
    params.require(:summary).permit(:content, :summary, :title)
  end
end

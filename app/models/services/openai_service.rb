require 'openai'

class OpenaiService
  def initialize(content)
    @content = content
    @client = OpenAI::Client.new(access_token: Rails.application.credentials.OPENAI_ACCESS_TOKEN)
  end

  def call
    return @content if @content.length < 10

    response = @client.chat(
      parameters: {
        model: 'gpt-4o-mini',
        messages: [
          { role: 'system',
            content:
            "あなたは、入力された情報を厳密に要約するAIアシスタントです。以下の条件に従って、要約を行ってください：
          1. 入力された内容を厳密に要約すること。
          2. 書いてない情報は絶対追加しないこと（質問や推測、対策案、メリット、注意点なども一切追加しない）。
          3. #{@content}の内容を、必ず・を用いた箇条書きで簡潔にまとめること(例: ・内容1)。
          4. ・を用いた1つの箇条書きには、1つの情報のみを入れること。
          5. 小見出しは必ず番号付きで、番号と小見出し全体を**で囲んで太字にすること（例: **1. 小見出し**）。
          6. 小見出しの数が少なすぎないように注意すること。
          7. 各小見出しの直後には、必ず改行を入れること
          8. ・を用いた箇条書き同士の間には、必ず改行を入れること
          9. 各小見出しでまとめられた項目の直後には、必ず改行を入れること。
          10. 各行の間には、必ず空行は作らない。
          " },
          { role: 'user',
            content: "以下の内容を要約してください。#{@content}" }
        ]
      }
    )

    response.dig('choices', 0, 'message', 'content')
  end
end

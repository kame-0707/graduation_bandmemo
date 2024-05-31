require 'openai'

class OpenaiService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  def summarize(content)
    response = @client.completions(
      parameters: {
        model: 'text-davinci-003',
        prompt: "次の文章を要約してください: #{content}",
        max_tokens: 50,
        temperature: 0.7
      }
    )
    response['choices'][0]['text'].strip
  rescue => e
    Rails.logger.error("OpenAI API error: #{e.message}")
    nil
  end
end

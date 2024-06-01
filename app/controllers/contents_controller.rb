# app/controllers/summaries_controller.rb
class SummariesController < ApplicationController
  def new
    @summary = Summary.new
  end

  def create
    client = OpenAI::Client.new
    response = client.completions(
      parameters: {
        model: "text-davinci-003",
        prompt: "以下のコンテンツを要約してください: #{params[:summary][:content]}",
        max_tokens: 50
      }
    )

    summary_text = response.dig("choices", 0, "text").strip

    @summary = Summary.new(content: params[:summary][:content], summary: summary_text)

    if @summary.save
      redirect_to @summary
    else
      render :new
    end
  end

  def index
    @summaries = Summary.all
  end

  def show
    @summary = Summary.find(params[:id])
  end
end

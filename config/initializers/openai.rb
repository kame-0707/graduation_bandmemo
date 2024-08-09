# frozen_string_literal: true

OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.OPENAI_ACCESS_TOKEN
  config.log_errors = true # Optional, but recommended for development
end

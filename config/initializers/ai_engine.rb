require "dotenv/load"
Dotenv.load("../../.env")

AI::Engine.setup do |config|
  config.openai_access_token = ENV.fetch("OPENAI_ACCESS_TOKEN", Rails.env.test? ? "dummy-token" : nil)
  config.openai_organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID", nil)
end

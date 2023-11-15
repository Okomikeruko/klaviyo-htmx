# frozen_string_literal: true

# Load the gem
require 'klaviyo-api-sdk'

# Setup authorization
KlaviyoAPI.configure do |config|
  config.api_key['Klaviyo-API-Key'] = 'Klaviyo-API-Key pk_a167c6e0af6cca6d6a86c4f08cb2c91764'
  # config.max_retries = 5 # optional
  # config.max_delay = 60 # optional
end

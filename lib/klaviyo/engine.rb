# frozen_string_literal: true

require 'klaviyo-api-sdk'
require 'haml-rails'

module Klaviyo
  # The Klaviyo::Engine class is responsible for providing engine functionality
  # for integrating Klaviyo services into a Rails application.
  #
  # Klaviyo is an email marketing platform that offers various features for
  # managing and analyzing customer interactions.
  class Engine < ::Rails::Engine
    # This line is crucial for isolating the Klaviyo engine within the host
    # application. It ensures that the engine's routes, models, and other
    # components do not conflict with those of the host application.
    isolate_namespace Klaviyo
  end
end

# frozen_string_literal: true

require 'klaviyo-api-sdk'
require 'haml-rails'

module Klaviyo
  class Engine < ::Rails::Engine
    isolate_namespace Klaviyo
  end
end

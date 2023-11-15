# frozen_string_literal: true

module Klaviyo
  # The ApplicationMailer class is not used in this engine,
  # and you can safely delete it if mailer functionality is not needed.
  class ApplicationMailer < ActionMailer::Base
    default from: 'from@example.com'
    layout 'mailer'
  end
end

# frozen_string_literal: true

module Klaviyo
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end

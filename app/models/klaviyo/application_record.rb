# frozen_string_literal: true

module Klaviyo
  # ApplicationRecord serves as the base class for models within the Klaviyo engine.
  # When using ActiveRecord, this class is set as an abstract class.
  # If your engine involves database models, this class provides common functionalities.
  # If your engine doesn't use ActiveRecord or doesn't have models, you can exclude this file.
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end

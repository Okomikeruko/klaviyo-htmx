# frozen_string_literal: true

require 'test_helper'

module Klaviyo
  class MetricsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    test 'should get index' do
      get metrics_path
      assert_response :success
      assert_template 'klaviyo/metrics/index'
    end

    test 'should get show' do
      get metric_path('YgaPzY')
      assert_response :success
      assert_template 'klaviyo/metrics/show'
    end
  end
end

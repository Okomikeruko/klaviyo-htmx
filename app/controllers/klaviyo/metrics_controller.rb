# frozen_string_literal: true

module Klaviyo
  class MetricsController < ApplicationController
    def index
      @metrics = KlaviyoAPI::Metrics.get_metrics
    end

    def show
      @metric = KlaviyoAPI::Metrics.get_metric params[:id]
    end


    def query_aggregates
      @aggregates = KlaviyoAPI::Metrics.query_metric_aggregates(metric_query(params[:id]))

      render layout: false
    end

    private

    # Builds a JSON representation of a metric-aggregate query.
    #
    # @param metric_id [String] The ID of the metric.
    # @param options [Hash] Additional options for the query.
    # @return [String] JSON representation of the metric-aggregate query.
    def metric_query(metric_id, options = {})
      { data: { type: 'metric-aggregate', attributes: {
        metric_id:,
        interval: options.fetch(:interval, 'week'),
        page_size: options.fetch(:page_size, 500),
        timezone: options.fetch(:timezone, 'America/Denver'),
        filter: build_filter(options),
        measurements: %w[unique sum_value count]
      } } }.to_json
    end

    # Builds the filter for the metric-aggregate query based on options.
    #
    # @param options [Hash] Additional options for the query.
    # @return [Array] The filter for the metric-aggregate query.
    def build_filter(options)
      start_time = options.fetch(:start_time, 7.days.ago.beginning_of_day)
      end_time   = options.fetch(:end_time, 0.days.ago.end_of_day)
      filter     = options.fetch(:filter, [])

      filter << "greater-or-equal(datetime,#{start_time.iso8601(6)})"
      filter << "less-than(datetime,#{end_time.iso8601(6)})"

      filter
    end

    def metric_query_params; end
  end
end

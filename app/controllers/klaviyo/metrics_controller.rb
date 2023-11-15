# frozen_string_literal: true

module Klaviyo
  # MetricsController handles actions related to Klaviyo metrics.
  class MetricsController < ApplicationController
    # GET /klaviyo/metrics
    # Fetches and displays a list of metrics.
    def index
      @metrics = KlaviyoAPI::Metrics.get_metrics
    end

    # GET /klaviyo/metrics/:id
    # Displays details of a specific metric.
    def show
      @metric = KlaviyoAPI::Metrics.get_metric params[:id]
    end

    # POST /klaviyo/metrics/:id/query_aggregates
    # Initiates a metric-aggregate query and renders the result without layout.
    def query_aggregates
      @aggregates = KlaviyoAPI::Metrics.query_metric_aggregates(metric_query(params[:id]), metrics_query_params)

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

    # Defines strong parameters for the metrics query.
    #
    # If the 'metric_query' parameter is present in the request, the method
    # permits specific fields and returns a strong parameters object.
    # Otherwise, an empty hash is returned.
    #
    # @return [ActionController::Parameters, {}] Strong parameters object
    #   containing permitted fields for metrics query if 'metric_query' is present,
    #   otherwise an empty hash.
    def metrics_query_params
      if params[:metric_query].present?
        params.require(:metric_query)
              .permit(:id, :interval, :page_size, :timezone, :start_time,
                      :endtime, filter: [])
      else
        {}
      end
    end
  end
end

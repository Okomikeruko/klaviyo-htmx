# frozen_string_literal: true

Klaviyo::Engine.routes.draw do
  root to: 'metrics#index'
  resources :metrics, only: %i[index show] do
    post :query_aggregates, on: :member
  end
end

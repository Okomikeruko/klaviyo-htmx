# frozen_string_literal: true

Rails.application.routes.draw do
  mount Klaviyo::Engine => '/klaviyo'
end

# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :sage do
      resource :clockin, only: :create
      resource :clockout, only: :create
      resource :current, only: :create
      resource :pause, only: :create
    end
  end
end

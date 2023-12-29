# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :citizens, except: :destroy
  match 'send_mail', to: 'citizen#create', via: 'post'
  match 'send_mail', to: 'citizen#update', via: 'patch'
end

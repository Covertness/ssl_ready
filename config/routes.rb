Rails.application.routes.draw do
  get 'welcome/index'

  # remove except after add auth
  resources :domains, except: %i[update destroy]

  root 'welcome#index'
end

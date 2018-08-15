Rails.application.routes.draw do
  get 'welcome/index'

  # remove except after add auth
  resources :domains, except: %i[update destroy] do
    collection do
      post :check
    end
  end

  root 'welcome#index'
end

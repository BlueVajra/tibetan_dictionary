Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  root 'welcome#index'
  get '/about', to: 'welcome#about'
  get '/contact', to: 'welcome#contact'
  get '/my_home', to: 'welcome#user'

  resources :tib_terms do
    resources :definitions
  end

  resources :glossaries do
    resources :definitions, only: [:create, :edit, :update]
  end

  get '/glossaries_test', to: 'glossaries#index_test'
  get '/glossaries_test/:id', to: 'glossaries#show_test'

  put '/glossaries/:id/default', to: 'glossaries#default', as: :default_glossary

end

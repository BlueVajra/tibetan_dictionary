Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  root 'welcome#index'
  get '/about', to: 'welcome#about'
  get '/contact', to: 'welcome#contact'
  get '/my_home', to: 'welcome#user'

  resources :tib_terms do
    resources :definitions, except: [:destroy]
    resources :comments
  end

  resources :definitions, only: [:destroy, :edit, :update]

  resources :glossaries do
    resources :definitions, only: [:create, :edit, :update, :destroy]
    member do
      get :import, to: "glossaries#import_form"
      post :import, to: "glossaries#import"
    end
  end

  get '/glossaries_test', to: 'glossaries#index_test'
  get '/glossaries_test/:id', to: 'glossaries#show_test'

  put '/glossaries/:id/default', to: 'glossaries#default', as: :default_glossary

end

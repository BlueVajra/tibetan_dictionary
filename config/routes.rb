Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  root 'welcome#index'
  get '/about', to: 'welcome#about'
  get '/contact', to: 'welcome#contact'
  get '/my_home', to: 'welcome#user'


  resources :tib_terms do
    resources :definitions
  end

  resources :glossaries

  put '/glossaries/:id/default', to: 'glossaries#default', as: :default_glossary
  #post '/tib_terms/'

end

Rails.application.routes.draw do
  resources :exams

  get '/edit_question/:id' , to: 'admin/questions#edit_question', as: :edit_question

  get 'sessions/new'

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  namespace :admin do
    resources :questions
  end

  resources :users do
    member do
      get :confirm_email
    end
  end

  post '/result', to: 'admin/questions#result'
  resources :results
  get '/show', to: 'results#show'
end



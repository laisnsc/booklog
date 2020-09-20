Rails.application.routes.draw do
  #get 'path' => 'controller#action', as: :url_path
  get 'home' => 'home#index'
  root 'home#index'
  get 'search' => 'home#search', as: :search
  post 'get_search_response' => 'home#get_search_response', as: :get_search_response
  get 'register' => 'users#new'
  get 'edit_profile' => 'users#edit'
  resources :users, except: [:new, :edit, :destroy] do
    resources :lists, shallow: true
  end

  resources :book_lists, only: [:new, :create, :destroy]
  resources :user_books
  # post 'users' => 'users#create'
  resources :sessions, only: [:new, :create]
  delete 'logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
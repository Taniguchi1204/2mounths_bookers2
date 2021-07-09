Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only:[:create,:destroy]
    get "search" => "users#search"
  end
  resources :books do
    resource :favorites, only:[:create,:destroy]
    resources :book_comments, only: [:create,:destroy]
  end

  resources :groups, only:[:index,:show,:new,:edit,:update,:create] do
    resource :user_groups, only:[:create,:destroy]
  end
  resources :chats, only:[:show,:create]

  get "books_sort" => "books#books_sort"

  get "search" => "search#search"
end
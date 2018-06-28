Rails.application.routes.draw do
   namespace :v1 do
      resources :friendships, only: [:index, :create]
      get '/friendships/common' => 'friendships#common'
      resources :follows, only: [:index, :create]
      resources :blocks, only: :create
   end 
end

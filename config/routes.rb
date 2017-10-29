Rails.application.routes.draw do
  root 'destinations#index'
  namespace :api do
    namespace :v1 do
      resources :destinations, except: [:new, :edit]
    end
  end
  resources :destinations
end

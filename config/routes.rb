Rails.application.routes.draw do
  resources :ideas
  root "dummy#index"
end

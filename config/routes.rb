Rails.application.routes.draw do
  resources :categories do
    resources :todos
  end
end

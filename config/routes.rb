Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get '/dashboard', to: 'dashboard#index'

  resources :users do
    resources :projects, only: [:new, :create, :show, :index, :edit], shallow: true do
      resources :tickets, only: %I[show new edit]
    end
  end

  get "/users/:id/tickets", to: "tickets#index", as: "user_tickets"
end

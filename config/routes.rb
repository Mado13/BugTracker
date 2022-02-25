Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :users, except: :create do
    resources :projects, only: %I[new create show index edit], shallow: true do
      resources :tickets, only: %I[show new edit] do
        resources :comments, only: %I[create new edit update destroy]
      end
    end
  end

  get   '/dashboard',                 to: 'dashboard#dashboard'
  patch '/users/:id/projects/:id',    to: 'projects#update', as: 'update_project'
  patch '/tickets/:id/edit',          to: 'tickets#update'
  post  '/projects/:id/tickets/new',  to: 'tickets#create'
  post  '/users/create',              to: 'users#create',    as: 'create_user'
  get   '/users/:id/tickets',         to: 'tickets#index',   as: 'user_tickets'
end

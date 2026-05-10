Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # GET /gyms
  # POST /gyms
  # GET /gyms/:id
  # GET /gyms/:gym_id/members
  # GET /gyms/:gym_id/sessions
  # GET /gyms/:gym_id/active_users
  resources :gyms, only: %i[index show create] do
    resources :sessions, only: %i[index]
    resources :members, only: %i[index]
    resources :active_users, only: %i[index]
  end

  # GET /users/:user_id/memberships
  # POST /users/:user_id/memberships
  # DELETE /users/:user_id/memberships
  # GET /users/:user_id/visits
  # GET /users/:user_id/visits/:id
  # POST /users/:user_id/visits
  # PUT /users/:user_id/visits/:id/check_out
  resources :users, only: [] do
    resources :memberships, only: %i[index create destroy]
    resources :visits, only: %i[index show create] do
      member do
        patch :check_out
        put :check_out
      end
    end
  end
end

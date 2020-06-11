Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  resources :links do
    member do
      patch :password_check, as: 'check_password'
    end
  end
  get '/:token', to: 'links#run', as: 'run_link'
  get '/:id/edit', to: redirect('/links/%{id}/edit')
end

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/:token', to: 'links#run'
  get '/:token/info', to: 'links#show', as: 'link_info'
  post '/links', to: 'links#create'
  root to: 'pages#home'
  delete '/:id', to: 'links#destroy', as: 'link'
end

Rails.application.routes.draw do
  root  'play_entry#new'
  get   'play_entry/new'
  get   '/input', to: 'play_entry#new'
  post  '/input', to: 'play_entry#get_entry'

  resources :contents
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

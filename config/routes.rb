Rails.application.routes.draw do
  root  'play_entry/home'
  get   '/input', to: 'play_entry#home'
  post  '/input', to: 'play_entry#get_entry'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

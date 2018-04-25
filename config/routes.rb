Rails.application.routes.draw do
  get 'home/index'
  get 'home/new'
  post 'home/new'
  get 'events/new'

  get 'home/events'
  post 'home/events'

  get 'home/check'
  post 'home/check'

  root 'home#index'

  post 'home/redirect'
  get '/redirect', to: 'home#redirect', as: 'redirect'

  get '/callback', to: 'home#callback', as: 'callback'


  get '/calendars', to: 'check#calendars', as: 'calendars'

  get '/events/:calendar_id', to: 'home#check', calendar_id: /[^\/]+/

  get '/events', to: 'check#events', as: 'events'

  get '/events/:calendar_id', to: 'home#events', calendar_id: /[^\/]+/





  post '/events/:calendar_id', to: 'check#new_event', as: 'new_event', calendar_id: /[^\/]+/
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

ActionController::Routing::Routes.draw do |map|
  map.root :controller => "questions"

  map.resource :session
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'

  map.resources :questions do |question|
    question.resources :answers
  end

  map.resources :openid_regexes

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

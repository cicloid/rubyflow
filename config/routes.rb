ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'items'

  map.resources :items,
                :collection => {:recently => :get},
                :member => {:star => :get, :unstar => :get} do |items|
    items.resources :comments
  end

  map.resources :categories

  map.with_options :controller => 'sessions'  do |m|
    m.login  '/login',  :action => 'new'
    m.logout '/logout', :action => 'destroy'
  end
  map.resources :users
  map.resource :session

  map.signup '/signup', :controller => 'users', :action => 'new'

  map.tag  '/tag/:id', :controller => 'items', :action => 'list_for_tags'
  map.tags '/tags/:id', :controller => 'items', :action => 'list_for_tags'
  map.tags_by_folders '/tags/*id', :controller => 'items', :action => 'list_for_tags'
  map.search   '/search/:id', :controller => 'items', :action => 'search'
  map.category '/category/:id', :controller => 'items', :action => 'category'

  map.connect '/page/:page', :controller => 'items', :action => 'index'
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

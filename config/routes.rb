ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'microsite'
  map.links "links", :controller => 'microsite', :action => 'links'
  map.our_goal "our_goal", :controller => 'microsite', :action => 'our_goal'
  map.prizes "prizes", :controller => 'microsite', :action => 'prizes'
  map.media "media", :controller => 'microsite', :action => 'media'
  map.follow_the_tour "follow_the_tour", :controller => 'microsite', :action => 'follow_the_tour'
  map.calculator "calculator", :controller => 'microsite', :action => 'calculator'
  map.contact "contact", :controller => "microsite", :action => "contact"
  map.send_message "send_message", :controller => "microsite", :action => "send_message", :method => :post
  map.task_dashboard "tasks", :controller => 'task_dashboard'
  map.complete_tasks "/tasks/complete", :controller => 'task_dashboard', :action => 'complete'
  map.complete_single_task "/tasks/:id/complete_single", :controller => 'task_dashboard', :action => 'complete_single'
  map.restart_task "/tasks/:id/restart", :controller => 'task_dashboard', :action => 'restart'
  map.sign_in '/sign_in', :controller => 'sessions', :action => 'new'
  map.sign_out '/sign_out', :controller => 'sessions', :action => 'destroy', :method => :delete

  map.resource :testimonials, :only => [:new, :create, :destroy], :member => {:approve => :put}
  map.namespace :testimonials do |testimonials|
    testimonials.resources :published_testimonials, :only => [:index], :member => {:hide => :put}, :collection => {:sort => :post}, :as => :published
    testimonials.resources :unpublished_testimonials, :only => [:index, :destroy], :member => {:approve => :put}, :as => :unpublished
    testimonials.resources :wholesalers_testimonials, :only => [:index], :member => {:approve => :put}, :as => :wholesalers
  end

  map.resources :task_templates
  map.resources :wholesalers, :collection => { :upload => :get, :import => :post, :winners => :get } do |wholesaler|
    wholesaler.resources :tasks, :except => :index
    wholesaler.resources :testimonials, :except => [:index, :edit, :update], :member => {:approve => :put }
    wholesaler.resources :photos
    wholesaler.resources :plumbers, :only => :index
    wholesaler.resources :parts, :only => :index
    wholesaler.resource  :user, :only => [:new, :create, :edit, :update]
  end
  map.resources :regions, :has_many => :media_outlets
  map.resources :media_outlets, :controller => :standalone_media_outlets
  map.resources :faqs, :collection => { :manage => :get, :sort => :post }, :member => {:approve => :put, :hide => :put }
  map.resources :followups, :only => [:index, :create, :destroy], :member => {:mark_complete => :put, :restart => :put }
  map.resources :schedules, :only => [:index, :show]
  map.resource :water_saving, :as => :water_savings, :only => [:show, :edit, :update]
  map.resources :prospects, :except => [:create, :new], :collection => { :subscribe => :post }
  map.resource :dashboard, :only => [:show], :member => {:contact_manager => :put} do |dashboard|
    dashboard.resources :plumbers, :only => [:new, :create]
    dashboard.resources :parts, :only => [:new, :create], :as => :products
  end
  map.resource :session, :only => [:new, :create, :destroy]
  map.resource :progress, :only => [:show]
  map.resources :winners, :only => [:new, :create, :destroy, :index], :collection => { :sort => :post }
end

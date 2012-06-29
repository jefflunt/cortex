Cortex::Application.routes.draw do
  root :to => 'thought_walls#create'
  
  match '/auth/:provider/callback', to: 'sessions#create'
  match "/auth/failure" => "sessions#failure"
  match "/signout" => "sessions#destroy", :as => :signout
  
  resources :thought_walls, :only => [:export, :create, :update, :show] do
    get 'export', :on => :member
    put 'toggle_star', :on => :member
  end
  
  resources :thoughts, :only => [:show, :create, :edit, :update]
  
  match "/:id" => "thought_walls#show"
end

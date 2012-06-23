Cortex::Application.routes.draw do
  root :to => 'thought_walls#create'
  
  resources :thought_walls, :only => [:export, :create, :update, :show] do
    get 'export', :on => :member
  end
  
  resources :thoughts, :only => [:show, :create, :edit, :update]
  
  match "/about" => "thought_walls#index"
  match "/:id" => "thought_walls#show"
  match '/auth/:provider/callback', to: 'sessions#create'
end

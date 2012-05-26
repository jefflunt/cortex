Cortex::Application.routes.draw do
  root :to => 'thought_walls#create'
  
  resources :thought_walls, :only => [:index, :create, :update, :show]
  resources :thoughts, :only => [:create, :update]
  
  match "/about" => "thought_walls#index"
  match "/:id" => "thought_walls#show"
end

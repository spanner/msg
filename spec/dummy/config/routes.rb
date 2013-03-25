Dummy::Application.routes.draw do

  mount Msg::Engine => "/msg", :as => :msg

  devise_for :users
  resources :users
  root :to => "users#index"

end

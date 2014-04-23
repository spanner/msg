Dummy::Application.routes.draw do

  mount Msg::Engine => "/msg", :as => :msg

  resources :users
  root :to => "users#index"

end

Msg::Engine.routes.draw do

  resources :messages do
    resources :sendings, :only => [:new, :create]
    member do
      get :preview
    end
    collection do
      get :transactional
      get :saved
    end
  end
  
  resources :sendings

  # envelopes#show is pinged when a message is opened
  resources :envelopes, :only => [:show]

  # bounces#create is called from the email receiver
  resources :bounces, :only => [:create]

end

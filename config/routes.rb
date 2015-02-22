PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  # get '/posts', to: 'posts#index'
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'posts#create'
  # get '/posts/:id/edit', to: 'posts#edit'
  # patch '/posts/:id', to: 'posts#update'
  # delete '/psots/:id', to: 'posts#destroy'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts, except: [:destroy] do
    member do  #member is for the extra action of every members of a resource
      post :vote  #will generate POST /posts/3/vote
    end

    # collection do  #page not for a specific member of a resource
    #   get :archives  #will generate GET /posts/archives
    # end

    resources :comments, only: [:create, :show] do
      member do  #member is for the extra action of every members of a resource
        post :vote  #will generate POST /posts/3/comments/4/vote
      end
    end


  end

  resources :categories, only: [:index, :new, :create, :show]
  resources :users, only: [:new, :create, :edit, :update, :show]

end

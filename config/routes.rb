Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    registrations: 'users/registrations' ,
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: [:index,:show,:edit,:update] do
    resources :reports
  end
  resources :plans
  get 'likes/:item_id/create', to: 'likes#create'
  get 'likes/:item_id/destroy', to: 'likes#destroy'
  resources :diaries
  resources :homes do
    collection do
      get "logout"
      get "about"
    end
  end
  resources :foods, only: [:index,:show,:new,:create] do
    member do
      post 'upload'
    end
    collection do
      get "search"
      get "upload"
    end
  end
  resources :signup do
    collection do
      get 'reset'
      get 'step1' # 1ページ目 (メールアドレスで登録する、フェイスブックで登録する、グーグルで登録する。)
      get 'step2' # ニックネームメール/PW
      get 'step3' # 住所
      get 'done'
    end
  end
end

Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, only: [:index,:show,:edit,:update] do
    resources :reports
  end
  resources :plans
  resources :homes do
    collection do
      get "logout"
      get "about"
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

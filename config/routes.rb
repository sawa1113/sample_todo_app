Rails.application.routes.draw do
  # Todo画面をトップページに設定
  root "users#show"

  # Deviseルート
  devise_for :users, controllers: {
    # ↓ローカルに追加されたコントローラーを参照する(コントローラー名: "コントローラーの参照先")
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }
  get 'users/show' => "users#show"

  # Rails DBエンジン
  mount RailsDb::Engine => "/rails/db", as: 'custom_rails_db'

  # Todoリソース
  resources :todos do
    member do
      delete :remove_attachment
    end
  end
end

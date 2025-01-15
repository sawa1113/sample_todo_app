Rails.application.routes.draw do
  mount RailsDb::Engine => "/rails/db", as: 'custom_rails_db'
  resources :todos do
    member do
      delete :remove_attachment
    end
  end
end

Rails.application.routes.draw do
  resources :todos
  mount RailsDb::Engine => "/rails/db", as: 'custom_rails_db'
end

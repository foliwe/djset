Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
 root to:'home#index'
 resource :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

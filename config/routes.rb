Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
 root to:'home#index'
 resource :events
 get '/buyticket' => 'events#buy'
 get '/payment_successful' => 'events#payment_successful'
 delete '/delete_image' => 'events#destroy_image', as: 'delete_image'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

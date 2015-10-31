Rails.application.routes.draw do
  resources :email_addresses
  resources :phone_numbers
  resources :people
end

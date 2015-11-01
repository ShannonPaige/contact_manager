Rails.application.routes.draw do
  resources :companies
  resources :email_addresses
  resources :phone_numbers
  resources :people
end

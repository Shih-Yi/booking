Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :reservations do
    post :update_status
  end

  root 'home#index'
  get 'table_pdf', to: 'home#table_pdf'
end

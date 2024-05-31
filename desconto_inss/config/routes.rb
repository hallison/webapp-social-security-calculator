Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'proponents#index'

  resources :proponents do
    put :update_salary, on: :member, to: "proponents#update_salary_net"
  end
end

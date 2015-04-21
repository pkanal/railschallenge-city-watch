Rails.application.routes.draw do
  defaults format: 'json' do
    resources :emergencies, param: :code
  end
end

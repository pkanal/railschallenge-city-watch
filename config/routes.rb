Rails.application.routes.draw do
  defaults format: 'json' do
    resources :emergencies, param: :code
    resources :responders, param: :name
  end
end

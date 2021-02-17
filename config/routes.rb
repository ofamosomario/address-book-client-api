Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, controllers: { registrations: 'registrations' }
  
  namespace :api, defaults: { format: :json } do
    
    namespace :v1 do
      
      resources :organizations
      resources :addressbooks

      post :auth, to: 'authentication#create'
      get  '/auth' => 'authentication#fetch'

      post  :'/organizations/register-as-admin',  to: 'organizations#register_as_admin'

      get   :'/addressbooks/list-organization-contacts/',  to: 'addressbooks#list_organization_contacts', defaults: { format: :json }
      get   :'/addressbooks/search-contact-by-name/',      to: 'addressbooks#search_contact_by_name', defaults: { format: :json }
      get   :'/test/',                                     to: 'organizations#test'
    end

  end

end

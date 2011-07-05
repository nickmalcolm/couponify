Couponify::Application.routes.draw do
  
  resources :discount_templates

  resources :discounts, :only => [:index, :show]
  
  match 'statistics'         => "statistics#index"

  root :to                   => 'home#index'

  match 'login'              => 'login#index'

  match 'login/authenticate' => 'login#authenticate'

  match 'login/finalize'     => 'login#finalize'

  match 'login/logout'       => 'login#logout'

end

YodleeResearch::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'yodlee_research#index'

  post 'yodlee_research/authenticate_cobrand' => 'yodlee_research#authenticate_cobrand'
  post 'yodlee_research/login_consumer' => 'yodlee_research#login_consumer'
  post 'yodlee_research/search_sites' => 'yodlee_research#search_sites'
  post 'yodlee_research/get_site_login_form' => 'yodlee_research#get_site_login_form'
  post 'yodlee_research/add_site_account' => 'yodlee_research#add_site_account'
  post 'yodlee_research/get_user_accounts' => 'yodlee_research#get_user_accounts'

end

ActionController::Routing::Routes.draw do |map|


  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  #map.connect '', :controller => "home", :action => "index2"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  #map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  #map.connect ':controller/:action/:id.:format'
  #map.connect ':controller/:action/:id'
  map.show_ajax '/:container_type/:container_id/events/show_ajax/:id', :controller => 'events', :action => 'show_ajax'
  map.show_ajax '/events/show_ajax/:id', :controller => 'events', :action => 'show_ajax'
  
  map.show_calendar '/:container_type/:container_id/events/show_calendar', :controller => 'events', :action => 'show_calendar'
  map.show_calendar '/events/show_calendar', :controller => 'events', :action => 'show_calendar'
  map.new_space   '/spaces/new', :controller =>'spaces', :action=>'new'
 
  map.resources :spaces do |space|
    space.resources :users do |user|
      user.resource :profile
    end
  end
  
  # #######################################################################
  # CMSplugin
  #  
  map.resources :posts, :member => { :media => :any,
                                     :get => :edit_media,
                                     :put => :update_media }
  map.resources :posts, :path_prefix => '/:container_type/:container_id',
                        :name_prefix => 'container_'

  CMS.contents.each do |content|
      map.resources content
      map.resources content, :path_prefix => '/:container_type/:container_id',
                             :name_prefix => 'container_'
  end
  
  
  
  map.open_id_complete 'session', { :open_id_complete => true,
                                    :conditions => { :method => :get },
                                    :controller => "sessions",
                                    :action => "create" }
  map.resource :session
  map.resource :notifier
  map.resource :machines  
  
  
  map.resources :events, :member =>'export_ical'
  #map.resources :users do |users|
  #    users.resource :profile
  #end
  
map.resources :users
  map.resources :roles
  map.connect ':controller/:action.:format/:container_id'
  map.connect ':controller/:action.:format/:container_id/:role_id'
  
  #SPACES CONTROLLER
  map.add_user2 '/spaces/:space_id/add_user2', :controller => "spaces", :action => "add_user2"
  map.register_user '/spaces/:space_id/register_user', :controller => "spaces", :action => "register_user"
  map.remove_user '/spaces/:space_id/remove_user', :controller => "spaces", :action => "remove_user"
  map.add_user '/spaces/:space_id/add_user', :controller=> 'spaces', :action => 'add_user'
   map.register '/spaces/:space_id/register', :controller=> 'users', :action => 'new'
  
  #explicit routes ORDERED BY CONTROLLER
  
map.search_articles '/:container_type/:container_id/search_articles', :controller => 'articles', :action=> 'search_articles'
 
map.search_all '/:container_type/:container_id/search_all', :controller => 'home', :action=> 'search'
  #EVENTS CONTROLLER
  map.show_timetable '/events/show_timetable' , :controller => "events", :action => "show_timetable"
  map.show_summary '/:container_type/:container_id/show_summary/:id' , :controller => "events", :action => "show_summary"
  map.add_participant '/add_participant', :controller => 'events', :action => 'add_participant'
  map.remove_participant '/remove_participant', :controller => 'events', :action => 'remove_participant'
  map.export_ical '/events/:id/export_ical', :controller => 'events' , :action => 'export_ical'
  map.remove_time '/:container_type/:container_id/remove_time', :controller => 'events', :action => 'remove_time'
  map.add_time '/:container_type/:container_id/add_time', :controller => 'events', :action => 'add_time'
  map.copy_next_week '/:container_type/:container_id/copy_next_week', :controller => 'events', :action => 'copy_next_week'
  
  #map.show '/:container_type/:container_id/events',:controller => 'events', :action => 'index'
  map.search '/:container_type/:container_id/search', :controller => 'events', :action => 'search'
  map.search_by_tag '/:container_type/:container_id/tags/:tag', :controller => 'events', :action => 'search_by_tag'
  map.search_events '/:container_type/:container_id/search_events', :controller => 'events', :action => 'search_events'
  map.advanced_search_events '/:container_type/:container_id/advanced_search_events', :controller => 'events', :action => 'advanced_search_events'
  map.search_by_title '/:container_type/:container_id/search_by_title', :controller => 'events', :action => 'search_by_title'
 map.search_in_description '/:container_type/:container_id/search_description', :controller => 'events', :action => 'search_in_description'
 map.search_by_date '/:container_type/:container_id/search_by_date', :controller => 'events', :action => 'search_by_date'

 map.advanced_search '/:container_type/:container_id/advanced_search', :controller => 'events', :action => 'advanced_search'
 map.title '/:container_type/:container_id/title_search', :controller => 'events', :action => 'title'
 map.description '/:container_type/:container_id/description_search', :controller => 'events', :action => 'description'
 map.clean '/:container_type/:container_id/clean', :controller => 'events', :action => 'clean'
  map.dates '/:container_type/:container_id/search_by_dates', :controller => 'events', :action => 'dates'
   #PROFILES CONTROLLER
  map.profile '/:container_type/:container_id/users/:user_id/profile', :controller => 'profiles' , :action => 'show'   
  map.new_profile '/:container_type/:container_id/users/:user_id/profile/new', :controller => 'profiles' , :action => 'new'   
  map.vcard '/users/:user_id/vcard/', :controller => 'profiles' , :action => 'vcard'   
  map.hcard '/users/:user_id/hcard/', :controller => 'profiles' , :action => 'hcard'   
  #USERS CONTROLLER
  map.show_space_users '/:container_type/:container_id/space_users', :controller => 'users' , :action => 'show_space_users'   
  map.clean_show '/clean_event', :controller => 'events', :action => 'clean_show'
  map.clean '/clean_search', :controller => 'users', :action => 'clean'
 map.organization '/search_in_organization', :controller => 'users', :action => 'organization'
 map.search_by_tag '/search_tag', :controller => 'users', :action=> 'search_by_tag'
  map.search_users '/:container_type/:container_id/search_users', :controller => 'users', :action=> 'search_users'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.forgot '/forgot', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password/:reset_password_code', :controller =>"users", :action => "reset_password"  
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.manage_users '/:container_type/:container_id/manage_users', :controller => 'users', :action => 'manage_users'
  map.search_users2 '/:container_type/:container_id/search_all_users', :controller => 'users', :action => 'search_users2'
  map.reset_search 'reset_search', :controller => 'users', :action => 'reset_search'
  map.clean2 '/clean2_search', :controller => 'users', :action => 'clean2'
   #SESSIONS CONTROLLER 
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  #LOCALE CONTROLLER (GLOBALIZE)
  map.connect ':locale/:controller/:action/:id'  
  map.set 'locale/set/:id', :controller => 'locale' , :action => 'set'
  #MACHINES CONTROLLER
  map.my_mailer 'machines/my_mailer', :controller => 'machines' , :action => 'my_mailer'
  map.contact_mail 'contact_mail' , :controller => 'machines', :action => 'contact_mail'
  map.list_use_machines 'machines/list_user_machines' , :controller => 'machines' , :action => 'list_user_machines'
  map.get_file 'get_file/:id' ,  :controller => "machines", :action => "get_file"  
  map.manage_resources '/manage_resources', :controller => 'machines', :action => 'manage_resources'  
  #SIMPLE_CAPTCHA CONTROLLER
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
#ROLES CONTROLLER
map.save_group '/:container_type/:container_id/save_group', :controller => 'roles', :action=> 'save_group'
map.create_group '/:container_type/:container_id/create_group', :controller => 'roles', :action=> 'create_group'
map.show_groups '/:container_type/:container_id/show_groups', :controller => 'roles', :action=> 'show_groups'
map.delete_group '/:container_type/:container_id/delete_group/:group_id', :controller => 'roles', :action=> 'delete_group'
map.group_details '/:container_type/:container_id/group_details/:group_id', :controller => 'roles', :action=> 'group_details'
map.edit_group '/:container_type/:container_id/edit_group/:group_id', :controller => 'roles', :action=> 'edit_group'
map.update_group '/:container_type/:container_id/update_group/:group_id', :controller => 'roles', :action=> 'update_group'
map.root :controller => 'spaces', :action => 'show', :space_id => 1,:container_id=> 1


end

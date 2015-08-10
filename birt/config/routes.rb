# ActionController::Routing::Routes.draw do |map|
#   map.birts
# end
Rails.application.routes.draw do
  get 'birt/api', :to => 'birt/api#index'
end

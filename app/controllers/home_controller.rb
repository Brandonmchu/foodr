class HomeController < ApplicationController

def index
	@userfb = FbGraph::User.fetch(current_user.uid, access_token: current_user.token)
  @location = params[:last_address] || current_user.location 
  coords = Geocoder.search(current_user.location)[0].geometry["location"]
  @init_lat = params[:init_lat] || coords["lat"]
  @init_lng = params[:init_lng] || coords["lng"]
  if params[:init_lat] || params[:radius] || params[:category] || params[:deals] 
    @yelp = YelpSearch.yelpResult({ 
                         location: {lat: @init_lat, lng: @init_lng},
                         radius: params[:radius],
                         category: params[:category],
                         deals: params[:deals]
                      })
  else
    @yelp = YelpSearch.yelpResult({location: {lat: @init_lat, lng: @init_lng}})
  end
  respond_to do |format|
    format.html
    format.js
  end
end


end


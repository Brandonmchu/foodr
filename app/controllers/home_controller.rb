class HomeController < ApplicationController

def index
	@userfb = FbGraph::User.fetch(current_user.uid, access_token: current_user.token)
  @location = params[:last_address] || current_user.location 
  coords = Geocoder.search(current_user.location)[0].geometry["location"]
  @init_lat = params[:init_lat] || coords["lat"]
  @init_lng = params[:init_lng] || coords["lng"]
  if params[:init_lat]
    @yelp = yelpResult({ 
                         location: {lat: @init_lat, lng: @init_lng},
                         radius: params[:radius],
                         category: params[:category],
                         deals: params[:deals]
                      })
  else
    @yelp = yelpResult({location: {lat: @init_lat, lng: @init_lng}})
  end
  respond_to do |format|
    format.html
    format.js
  end
end

def yelpResult(args)
  yelpSearch = YelpSearch.searchYelp(args)
  mappedResults = map(yelpSearch)
  mappedResults.each do |result|
    Restaurant.create!(yelp_id: result[:id], name: result[:name]) unless Restaurant.find_by_yelp_id(result[:id])
  end
  return mappedResults
end

private
  def map(yelpSearch)
    yelpSearch.businesses.map {|l|
    {
      id: l.id,
      name: l.respond_to?("name") ? l.name : "nameless",
      categories: l.respond_to?("categories") ? l.categories : ["-"],
      rating: l.respond_to?("rating") ? l.rating : "unrated",
      review_count: l.respond_to?("review_count") ? l.review_count : "no reviews",
      url: l.respond_to?("url") ? l.url : "no url",
      phone: l.respond_to?("phone") ? l.phone : "no phone available"
    }}
  end

end


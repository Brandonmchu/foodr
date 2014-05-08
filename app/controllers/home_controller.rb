class HomeController < ApplicationController

def index
	@userfb = FbGraph::User.fetch(current_user.uid, access_token: current_user.token)
  if params[:location]
   @yelp = yelpResult({location: params[:location]})
  else
	 @yelp = yelpResult({location: @location})
  end
end

def yelpResult(args)
  yelpSearch = YelpSearch.searchYelp(args)
	mappedResults = yelpSearch.businesses.map {|l| {id: l.id, name: l.name, categories:l.categories, rating: l.rating, review_count: l.review_count, url: l.url, phone: l.phone}}
  mappedResults.each do |result|
    Restaurant.create!(yelp_id: result[:id], name: result[:name]) unless Restaurant.find_by_yelp_id(result[:id])
  end
  return mappedResults
end

end
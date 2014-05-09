class HomeController < ApplicationController

def index
	@userfb = FbGraph::User.fetch(current_user.uid, access_token: current_user.token)
  if params[:location]
    @yelp = yelpResult({ 
                         location: params[:location],
                         radius: params[:radius],
                         category: params[:category],
                         deals: params[:deals]
                      })
  elsif current_user.location.nil?
	  @yelp = yelpResult({})
  else
    @yelp = yelpResult({location: current_user.location})
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
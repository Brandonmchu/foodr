class YelpSearch < ActiveRecord::Base

def self.initYelp
	Yelp::Client.new({ consumer_key: ENV['YELP_CONSUMER_KEY'],
                     consumer_secret: ENV['YELP_CONSUMER_SECRET'],
                     token: ENV['YELP_TOKEN'],
                     token_secret: ENV['YELP_TOKEN_SECRET']
                  })
end

def self.searchYelp(args)
	yelpSession = initYelp
	term = args[:term] || 'restaurant'
	location = args[:location] || 'Toronto'
	category = args[:category] || ''
	radius = args[:radius] || '40000'
	deals = args[:deals] || false
	location = args[:location] || 'Toronto'
	coordinates = { latitude: location[:lat], longitude: location[:lng] }	
	calls = 0
    result = []
    for i in 1..2
    	calls = i*20+1
		params = { term: 'food',
       	   limit: 20,
       	   offset: calls,
       	   category_filter: category,
           radius_filter: radius,
       	   deals: deals
       	 }
    	result << yelpSession.search_by_coordinates(coordinates,params)
    end
    return result
end

def self.yelpResult(args)
  yelpSearch = searchYelp(args)
  mappedResults = []
  yelpSearch.each do |call_result|
  	mappedResults << map(call_result)
  end
  mappedResults.each do |result|
  	result.each do |call_result|
    	Restaurant.create!(yelp_id: call_result[:id], 
    					   name: call_result[:name],
    					   categories: call_result[:categories].join(","),
    					   rating: call_result[:rating],
    					   review_count: call_result[:review_count],
    					   url: call_result[:url],
    					   phone: call_result[:phone],
    					   distance: call_result[:distance],
    					   ) unless Restaurant.find_by_yelp_id(call_result[:id])
	end
  end
  return mappedResults
end

def self.map(yelpSearch)
	yelpSearch.businesses.map {|l|
	{
	  id: l.id,
	  name: l.respond_to?("name") ? l.name : "nameless",
	  categories: l.respond_to?("categories") ? l.categories.map {|v| v[0]} : ["-"],
	  rating: l.respond_to?("rating") ? l.rating : "unrated",
	  review_count: l.respond_to?("review_count") ? l.review_count : "no reviews",
	  url: l.respond_to?("url") ? l.url : "no url",
	  phone: l.respond_to?("phone") ? l.phone : "no phone available",
	  distance: l.respond_to?("distance") ? l.distance : "no distance available"
	}}
end

end

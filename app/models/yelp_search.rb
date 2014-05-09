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
	coordinates = { latitude: 43.653899, longitude: -79.447876 }	
	params = { term: 'food',
           	   limit: 10,
           	   sort: 1,
           	   category_filter: category,
               radius_filter: radius,
           	   deals: deals
           	 }
	if coordinates
		yelpSession.search_by_coordinates(coordinates,params)
	else 
		yelpSession.search(location,params)
	end
end

end

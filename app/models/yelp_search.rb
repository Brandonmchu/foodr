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
	deals = args[:radius] || false
	yelpSession.search(location, { term: 'food',
           						   limit: 10,
           						   sort: 2,
           						   category_filter: category,
           						   radius_filter: radius,
           						   deals: deals
         													})
end

end

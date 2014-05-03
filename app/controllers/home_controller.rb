class HomeController < ApplicationController

def index
	@user = current_user
	@userfb = FbGraph::User.fetch(current_user.uid, access_token: current_user.token)
	@yelp = initYelp
	@yelp = searchYelp(@yelp, @userfb.location.name)
	@yelp = mapYelp(@yelp)
end

def initYelp
	Yelp::Client.new({ consumer_key: ENV['YELP_CONSUMER_KEY'],
                     consumer_secret: ENV['YELP_CONSUMER_SECRET'],
                     token: ENV['YELP_TOKEN'],
                     token_secret: ENV['YELP_TOKEN_SECRET']
                  })
end

def searchYelp(yelpSession, location)
	yelpSession.search(location, { term: 'food',
           											 limit: 3,
           											 sort: 2
         													})
end

def mapYelp(yelpSearch)
	yelpSearch.businesses.map {|l| {name: l.name, categories:l.categories, rating: l.rating}}
end

end
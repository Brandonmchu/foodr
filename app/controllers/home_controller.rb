class HomeController < ApplicationController

def index
	@userfb = FbGraph::User.fetch(current_user.uid, access_token: current_user.token)
	@yelp = yelpResult
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
           											 limit: 10,
           											 sort: 2
         													})
end

def yelpResult
	yelpSearch = searchYelp(initYelp, @userfb.location.name)
	yelpSearch.businesses.map {|l| {name: l.name, categories:l.categories, rating: l.rating, review_count: l.review_count, url: l.url, phone: l.phone, }}
end

end
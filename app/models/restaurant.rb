class Restaurant < ActiveRecord::Base

validates :yelp_id, presence: true, uniqueness: true

end

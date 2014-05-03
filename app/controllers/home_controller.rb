class HomeController < ApplicationController
  def index
  	@user = current_user
  	@userfb = FbGraph::User.fetch(current_user.uid, access_token: current_user.token)
  end
end

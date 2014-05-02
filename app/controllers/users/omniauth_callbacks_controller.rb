class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

def facebook
  	auth = request.env['omniauth.auth']
	@user = User.from_facebook_auth(auth)
	sign_in_and_redirect @user
end

end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :preferences

  def self.from_facebook_auth(auth)
    if where(uid: auth.uid, provider: auth.provider).first
      user = where(uid: auth.uid, provider: auth.provider).first
    else
      user = User.create!(name: auth.info.name, email: auth.info.email, password: "Admin123", uid: auth.uid, provider: auth.provider)
      if auth.extra.raw_info.location
        user.update(location: auth.extra.raw_info.location.name) 
      else
        user.update(location: "Toronto") 
      end
    end
    user.update(token: auth.credentials.token, secret: auth.credentials.secret)
    return user
  end

end

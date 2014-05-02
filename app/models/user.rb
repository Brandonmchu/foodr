class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_facebook_auth(auth)
    user = where(uid: auth.uid, provider: auth.provider).first_or_create(name: auth.info.name, email: auth.info.email, password: "Admin123")
    user.update(token: auth.credentials.token, secret: auth.credentials.secret)
    return user
  end

end

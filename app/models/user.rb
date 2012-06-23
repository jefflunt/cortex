class User < ActiveRecord::Base
  has_many :thought_walls
  
  validates :uid, :uniqueness=>{:scope=>:provider}
        
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      
      case user.provider
      when "google_oauth2"
        user.provider = auth[:provider]
        user.uid = auth[:uid]
        user.name = auth[:info][:name]
        user.nickname = auth[:info][:nickname]
      end
    end
  end

end


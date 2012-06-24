class User < ActiveRecord::Base
  has_and_belongs_to_many :thought_walls, order: "lower(title) ASC"
  
  validates :uid, :uniqueness=>{:scope=>:provider}
        
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"].to_s
      
      case user.provider
      when "google_oauth2"
        user.provider = auth[:provider]
        user.uid = auth[:uid]
        user.name = auth[:info][:name]
        user.nickname = auth[:info][:nickname]
      when "github"
        user.name = auth["info"]["name"]
        user.nickname = auth["info"]["nickname"]
      when "facebook"
        user.name = auth["info"]["name"]
        user.nickname = auth["info"]["nickname"]
      when "twitter"
        user.provider = auth[:provider]
        user.uid = auth[:uid]
        user.name = auth[:info][:name]
        user.nickname = auth[:info][:nickname]
      end
    end
  end

end


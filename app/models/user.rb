class User < ApplicationRecord
    has_secure_password
    has_many :books 
    has_many :bookshelves
    has_many :reviews
    has_many :discussions 
    has_many :comments
    has_many :entered_discussions, through: :comments, source: :discussion
   

    validates :email, presence: true, uniqueness: true
    validates :password, length: { in: 6..20 }
    validates :bio, length: { maximum: 350 }

    def self.create_from_omniauth(auth)
        user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u| 
            u.username = auth['info']['name'] 
            u.email = auth['info']['name'] 
            u.password = SecureRandom.hex(12)
        end 
    end 

  
end

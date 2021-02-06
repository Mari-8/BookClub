class User < ApplicationRecord
    has_secure_password
    has_many :books 
    has_many :bookshelves 

    validates :email, presence: true, uniqueness: true


    def self.create_from_omniauth(auth)
        user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u| 
            u.username = auth['info']['name'] 
            u.email = auth['info']['name'] 
            u.password = SecureRandom.hex(12)
        end 
    end 
end

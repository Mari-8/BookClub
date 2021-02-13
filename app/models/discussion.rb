class Discussion < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :users, through: :comments
    
    validates :title, presence: true 
    validates :title, uniqueness: true 
end
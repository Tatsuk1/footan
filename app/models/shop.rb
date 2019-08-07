class Shop < ApplicationRecord
  has_many :posts
  has_many :users, through: :posts
  
  # validates :freeword, presence: true
end

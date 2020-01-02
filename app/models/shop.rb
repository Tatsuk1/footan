class Shop < ApplicationRecord
  has_many :posts
  has_many :users, through: :posts
  has_many :favorite_shops, dependent: :destroy
  has_many :favo_shops, through: :favorite_shops, source: :shop, dependent: :destroy
end

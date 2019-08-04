class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :shop
  
  has_many :favorites, dependent: :destroy
  has_many :favo_contents, through: :favorites, source: :post, dependent: :destroy
  
  validates :image, presence: true
  validates :content, presence: true
  validates :title, presence: true
end

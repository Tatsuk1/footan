class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :shop
  
  validates :image, presence: true
  validates :content, presence: true
  validates :title, presence: true
end

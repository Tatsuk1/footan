class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  attr_accessor :remember_token
 
   
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: {case_sensitive: false }
  has_secure_password

  class << self  
    
    #受理した文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    
    #ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
    
  #永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  #渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  #ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  has_many :posts
  has_many :shops, through: :posts
  has_many :favorites, dependent: :destroy
  has_many :favo_contents, through: :favorites, source: :post, dependent: :destroy
  has_many :favorite_shops, dependent: :destroy
  has_many :favo_shops, through: :favorite_shops, source: :shop
  
  def like(post)
    self.favorites.find_or_create_by(post_id: post.id)
  end
  
  def unlike(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end
  
  def favorite?(post)
    self.favo_contents.include?(post)
  end
  
  def like_shop(shop)
    self.favorite_shops.find_or_create_by(shop_id: shop.id)
  end
  
  def unlike_shop(shop)
    favorite = self.favorite_shops.find_by(shop_id: shop.id)
    favorite.destroy if favorite
  end
  
  def favo_shop?(shop)
    self.favo_shops.include?(shop)
  end
  
end

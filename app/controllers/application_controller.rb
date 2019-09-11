class ApplicationController < ActionController::Base
require 'net/http'
require 'json'
require 'uri'

  include SessionsHelper
  
  private
  
  def shop_list
    if params[:search].present?
    
      base_url='https://api.gnavi.co.jp/RestSearchAPI/v3'
      
      parameters = {
      'keyid' => ENV['GURUNAVI_API_KEY'],
      'freeword' => params[:search],
      'wifi' => params[:wifi],
      'outret' => params[:outret],
      'takeout' => params[:takeout],
      'hit_per_page' => 50,
      }
      
      p uri = URI(base_url + '?' + parameters.to_param)
      
      p response_json = Net::HTTP.get(uri)
      
      p response_data = JSON.parse(response_json)
      
      @rests = []
      rests = response_data['rest']
      
      if rests
        rests.each do |rest|
          shop = Shop.find_or_initialize_by(shop_code: rest['id'])
          if !shop.id.present?
            shop.shop_code = rest['id'] 
            shop.name = rest['name']
            shop.latitude = rest['latitude']
            shop.longitude = rest['longitude']
            shop.shop_url = rest['url']
            shop.pr = rest['pr']['pr_short']
            shop.image_url = rest['image_url']['shop_image1']
            shop.address = rest['address']
            shop.tel = rest['tel']
            shop.opentime = rest['opentime']
            shop.holiday = rest['holiday']
            shop.budget = rest['budget']
            shop.line = rest['access']['line']
            shop.station = rest['access']['station']
            shop.station_exit = rest['access']['station_exit']
            shop.walk = rest['access']['walk']
          end
          @rests << shop
        end
      else
        flash.now[:danger]='条件を満たす店舗が見つかりませんでした'
        render :index
      end
    end
  end
  
  def require_user_logged_in
    unless logged_in?
      flash[:warning] = "ログインして下さい。"
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_posts = user.posts.count
    @count_favo_contents = user.favo_contents.count
  end
end

# shop_data
    # t.string "name"
    # t.decimal "latitude", precision: 10, scale: 7
    # t.decimal "longitude", precision: 10, scale: 7
    # t.string "shop_url"
    # t.string "image_url"
    # t.string "address"
    # t.string "tel"
    # t.string "opentime"
    # t.string "holiday"
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false
    # t.string "freeword"
    # t.string "shop_code"
    # t.string "pr"
    
# for shukatsu

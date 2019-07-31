class ApplicationController < ActionController::Base
require 'net/http'
require 'json'
require 'uri'

  include SessionsHelper
  
  private
  
  def shop_list
    if params[:search].present?
    
      base_url='https://api.gnavi.co.jp/RestSearchAPI/v3'
      p freeword = params[:search]
      
      parameters = {
      'freeword' => freeword,
      'format' => 'json',
      'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006'
      }
      
      p uri = URI(base_url + '?' + parameters.to_param)
      
      p response_json = Net::HTTP.get(uri)
      
      p response_data = JSON.parse(response_json)
      
      @rests = []
      rests = response_data['rest']
      
      rests.each do |rest|
        shop = Shop.find_or_initialize_by(shop_code: rest['id'])
        if !shop.id.present?
          shop.shop_code = rest['id'] 
          shop.name = rest['name']
          shop.latitude = rest['latitude']
          shop.longitude = rest['longitude']
          shop.shop_url = rest['url']
          shop.image_url = rest['image_url']['shop_image1']
          shop.address = rest['address']
          shop.tel = rest['tel']
          shop.opentime = rest['opentime']
          shop.holiday = rest['holiday']
        end
        @rests << shop
        shop.save
      end
    end
  end
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end


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
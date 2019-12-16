class ApplicationController < ActionController::Base
require 'net/http'
require 'json'
require 'uri'

  include SessionsHelper
  
  private
  
  def category
    #binding.pry
    base_url = 'https://api.gnavi.co.jp/master/CategoryLargeSearchAPI/v3/'
    
    parameters = {
      'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006',
      'lang' =>'ja'
    }
    
    uri = URI(base_url + '?' + parameters.to_param)
    
    p response_json = Net::HTTP.get(uri)
    
    p response_data = JSON.parse(response_json)
    
    @categorys = []
    categorys = response_data['category_l']
    
    categorys.each do |category|
      point = Category.find_or_create_by(category_l_code: params['category_l_code'])
        point.category_l_code = category['category_l_code']
        point.category_l_name = category['category_l_name']
      @categorys << point
    end
  end

  def pref
    #binding.pry
    base_url = 'https://api.gnavi.co.jp/master/PrefSearchAPI/v3/'
    
    parameters = {
      'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006',
      'lang' =>'ja'
    }
    
    uri = URI(base_url + '?' + parameters.to_param)
    
    p response_json = Net::HTTP.get(uri)
    
    p response_data = JSON.parse(response_json)
    
    @prefs = []
    prefs = response_data['pref']
    
    prefs.each do |pref|
      point = Pref.find_or_create_by(pref_code: params['pref_code'])
        point.pref_code = pref['pref_code']
        point.pref_name = pref['pref_name']
      @prefs << point
    end
  end

  def area
    #binding.pry
    base_url = 'https://api.gnavi.co.jp/master/GAreaLargeSearchAPI/v3/'
    
    parameters = {
      'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006',
      'lang' =>'ja'
    }
    
    uri = URI(base_url + '?' + parameters.to_param)
    
    p response_json = Net::HTTP.get(uri)
    
    p response_data = JSON.parse(response_json)
    
    @areas = []
    areas = response_data['garea_large']
    
    areas.each do |area|
      point = AreaL.find_or_create_by(areacode_l: params['areacode_l'])
        point.areacode_l = area['areacode_l']
        point.areaname_l = area['areaname_l']
      @areas << point
    end
  end

  def shop_list
    #binding.pry
    if params[:search].present? || params[:category_l_code].present? || params[:pref_code].present?
    
      base_url='https://api.gnavi.co.jp/RestSearchAPI/v3'
      
      parameters = {
      'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006',
      'freeword' => params[:search],
      'wifi' => params[:wifi],
      'outret' => params[:outret],
      'takeout' => params[:takeout],
      'category_l' => params[:category_l_code],
      'pref' => params[:pref_code],
      'areacode_l' => params[:areacode_l],
      'hit_per_page' => 36
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
            shop.category_name_l = rest['code']['category_name_l']
          end
          @rests << shop
        end
      else
        flash.now[:danger]='条件を満たす店舗が見つかりませんでした'
        render :index
      end
    end
  end
  
  # def shop_list_instagram
  #   if params[:search].present?
    
  #     base_url='https://api.gnavi.co.jp/RestSearchAPI/v3'
      
  #     parameters = {
  #     'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006',
  #     'freeword' =>  params[:search],
  #     'category_l' => "RSFST18000",
  #     'hit_per_page' => 36,
  #     }
      
  #     p uri = URI(base_url + '?' + parameters.to_param)
      
  #     p response_json = Net::HTTP.get(uri)
      
  #     p response_data = JSON.parse(response_json)
      
  #     @rests_instagram = []
  #     rests = response_data['rest']
      
  #     if rests
  #       rests.each do |rest|
  #         shop = Shop.find_or_initialize_by(shop_code: rest['id'])
  #         if !shop.id.present?
  #           shop.shop_code = rest['id'] 
  #           shop.name = rest['name']
  #           shop.latitude = rest['latitude']
  #           shop.longitude = rest['longitude']
  #           shop.shop_url = rest['url']
  #           shop.pr = rest['pr']['pr_short']
  #           shop.image_url = rest['image_url']['shop_image1']
  #           shop.address = rest['address']
  #           shop.tel = rest['tel']
  #           shop.opentime = rest['opentime']
  #           shop.holiday = rest['holiday']
  #           shop.budget = rest['budget']
  #           shop.line = rest['access']['line']
  #           shop.station = rest['access']['station']
  #           shop.station_exit = rest['access']['station_exit']
  #           shop.walk = rest['access']['walk']
  #           shop.category_name_l = rest['code']['category_name_l']
  #         end
  #         @rests_instagram << shop
  #       end
  #     else
  #       flash.now[:danger]='条件を満たす店舗が見つかりませんでした'
  #       render :index
  #     end
  #   end
  # end
  
  # def shop_list_vegetable
  #   if params[:search].present?
    
  #     base_url='https://api.gnavi.co.jp/RestSearchAPI/v3'
      
  #     parameters = {
  #     'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006',
  #     'freeword' =>  params[:search],
  #     'category_l' => "RSFST17000",
  #     'category_s' => "RSFST17007",
  #     'hit_per_page' => 36,
  #     }
      
  #     p uri = URI(base_url + '?' + parameters.to_param)
      
  #     p response_json = Net::HTTP.get(uri)
      
  #     p response_data = JSON.parse(response_json)
      
  #     @rests_vegetable = []
  #     rests = response_data['rest']
      
  #     if rests
  #       rests.each do |rest|
  #         shop = Shop.find_or_initialize_by(shop_code: rest['id'])
  #         if !shop.id.present?
  #           shop.shop_code = rest['id'] 
  #           shop.name = rest['name']
  #           shop.latitude = rest['latitude']
  #           shop.longitude = rest['longitude']
  #           shop.shop_url = rest['url']
  #           shop.pr = rest['pr']['pr_short']
  #           shop.image_url = rest['image_url']['shop_image1']
  #           shop.address = rest['address']
  #           shop.tel = rest['tel']
  #           shop.opentime = rest['opentime']
  #           shop.holiday = rest['holiday']
  #           shop.budget = rest['budget']
  #           shop.line = rest['access']['line']
  #           shop.station = rest['access']['station']
  #           shop.station_exit = rest['access']['station_exit']
  #           shop.walk = rest['access']['walk']
  #           shop.category_name_l = rest['code']['category_name_l']
  #         end
  #         @rests_vegetable << shop
  #       end
  #     else
  #       flash.now[:danger]='条件を満たす店舗が見つかりませんでした'
  #       render :index
  #     end
  #   end
  # end
  
  def require_user_logged_in
    unless logged_in?
      flash[:warning] = "ログインして下さい。"
      store_location
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_posts = user.posts.count
    @count_favo_contents = user.favo_contents.count
    @count_favo_shops = user.favo_shops.count
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

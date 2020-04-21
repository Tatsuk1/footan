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

    @areal = []
    areas.each do |area|
      if area["pref"]["pref_code"] == "PREF13"
        point = AreaLl.find_or_create_by(areacode_l: "areacode_l")
        point.areacode_l = area['areacode_l']
        point.areaname_l = area['areaname_l']
        @areal << point
      end
    end
  end

  def shop_list
    #binding.pry
    if params[:search].present? || params[:category_l_code].present? || params[:areacode_l].present?
    
      base_url='https://api.gnavi.co.jp/RestSearchAPI/v3'
      
      parameters = {
      'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006',
      'freeword' => params[:search],
      'wifi' => params[:wifi],
      'outret' => params[:outret],
      'takeout' => params[:takeout],
      'category_l' => params[:category_l_code],
      'pref' => 'PREF13',
      'areacode_l' => params[:areacode_l],
      'hit_per_page' => 36
      }
      
      p uri = URI(base_url + '?' + parameters.to_param)
      
      p response_json = Net::HTTP.get(uri)
      
      p response_data = JSON.parse(response_json)
      
      @rests = []
      rests = response_data['rest']
      
      if params['customerBudget'] == ""
        customerBudget = 10000000
      else
        customerBudget = params['customerBudget'].to_i
      end

      if params['lowestBudget'] == ""
        lowestBudget = 0
      else
        lowestBudget = params['lowestBudget'].to_i
      end


      if rests
        rests.each do |rest|
          if customerBudget >= rest['budget'].to_i && lowestBudget<= rest['budget'].to_i
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
        end
        if @rests == []
          flash.now[:danger]='条件を満たす店舗が見つかりませんでした'
          render :index
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


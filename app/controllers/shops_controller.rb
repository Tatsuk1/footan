class ShopsController < ApplicationController
before_action :shop_list

  def index
    @shops = @rests
  end

  def show
    @shop = Shop.find(params[:id])
  end
  
  def create
    #binding.pry
    @shop = Shop.find_or_initialize_by(shop_code: params[:shop_code])
    return redirect_to @shop if !@shop.new_record?
    
    base_url='https://api.gnavi.co.jp/RestSearchAPI/v3'
      
    parameters = {
    'id' => @shop.shop_code,
    'format' => 'json',
    'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006'
    }

    uri = URI(base_url + '?' + parameters.to_param)

    response_json = Net::HTTP.get(uri)

    p rest = JSON.parse(response_json)['rest']
        
    @shop.shop_code = rest['id'] 
    @shop.name = rest['name']
    @shop.latitude = rest['latitude']
    @shop.longitude = rest['longitude']
    @shop.shop_url = rest['url']
    @shop.image_url = rest['image_url']['shop_image1']
    @shop.address = rest['address']
    @shop.tel = rest['tel']
    @shop.opentime = rest['opentime']
    @shop.holiday = rest['holiday']
    
    if @shop.save
      redirect_to @shop
    else
      redirect_back(fallback_location: root_url)
    end
  end
end

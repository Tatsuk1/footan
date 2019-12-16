class ShopsController < ApplicationController
before_action :shop_list
before_action :category
#before_action :shop_list_instagram
#before_action :shop_list_vegetable
before_action :require_user_logged_in, only:[:show]
  def index
    if @rests
      @shops = Kaminari.paginate_array(@rests).page(params[:page]).per(12)
    else
      flash.now[:danger]='条件を満たす店舗が見つかりませんでした'
      render :index
    end
  end

  def instagram
    if @rests_instagram
      @shops = Kaminari.paginate_array(@rests_instagram).page(params[:page]).per(12)
    else
      flash.now[:danger]='条件を満たす店舗が見つかりませんでした'
      render :index
    end
  end
  
  def vegetable
    if @rests_vegetable
      @shops = Kaminari.paginate_array(@rests_vegetable).page(params[:page]).per(12)
    else
      flash.now[:danger]='条件を満たす店舗が見つかりませんでした'
      render :index
    end
  end

  def show
    #binding.pry
    @shop = Shop.find(params[:id])
    @posts = @shop.posts.order(id: :desc)
  end
  
  def create
    #binding.pry
    @shop = Shop.find_or_initialize_by(shop_code: params[:shop_code])
    return redirect_to @shop if !@shop.new_record?
    
    base_url='https://api.gnavi.co.jp/RestSearchAPI/v3'
      
    parameters = {
    'id' => @shop.shop_code,
    'hit_per_page' => 50,
    'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006'
    }

    uri = URI(base_url + '?' + parameters.to_param)

    response_json = Net::HTTP.get(uri)

    p response_data = JSON.parse(response_json)
      
    rests = response_data['rest']
    
    rests.each do |rest|    
      @shop.shop_code = rest['id'] 
      @shop.name = rest['name']
      @shop.latitude = rest['latitude']
      @shop.longitude = rest['longitude']
      @shop.shop_url = rest['url']
      @shop.pr = rest['pr']['pr_short']
      @shop.image_url = rest['image_url']['shop_image1']
      @shop.address = rest['address']
      @shop.tel = rest['tel']
      @shop.opentime = rest['opentime']
      @shop.holiday = rest['holiday']
      @shop.budget = rest['budget']
      @shop.line = rest['access']['line']
      @shop.station = rest['access']['station']
      @shop.station_exit = rest['access']['station_exit']
      @shop.walk = rest['access']['walk']
    end
  
    if @shop.save
      redirect_to @shop
    else
      redirect_back(fallback_location: root_url)
    end
  end
end

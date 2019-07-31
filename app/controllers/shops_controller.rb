class ShopsController < ApplicationController
before_action :shop_list

  def index
    @shops = @rests
  end

  def show
   #binding.pry
    @shop = Shop.find_by_shop_code(params[:shop_code])
  end
end

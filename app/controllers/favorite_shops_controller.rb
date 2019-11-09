class FavoriteShopsController < ApplicationController
before_action :require_user_logged_in
before_action :set_shop
  def create
    current_user.like_shop(@shop)
    flash[:success] = 'お気に入りにしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unlike_shop(@shop)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
    def set_shop
      @shop = Shop.find(params[:shop_id])
    end
end

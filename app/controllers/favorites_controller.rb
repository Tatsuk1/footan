class FavoritesController < ApplicationController
before_action :require_user_logged_in
before_action :set_post
  def create
    current_user.like(@post)
    flash[:success] = 'お気に入りにしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unlike(@post)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
end

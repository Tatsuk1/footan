class FavoritesController < ApplicationController
before_action :require_user_logged_in
  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    flash[:success] = 'お気に入りにしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlike(post)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end

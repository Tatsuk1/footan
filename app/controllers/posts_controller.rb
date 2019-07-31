class PostsController < ApplicationController
  def new
   @shop = Shop.find_by_shop_code(:shop_code)
   @post = Post.new
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

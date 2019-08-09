class PostsController < ApplicationController
  before_action :require_user_logged_in, except:[:index]
  before_action :correct_user, only: [:destroy]
  
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(20)
  end
  
  def new
   @shop = Shop.find(params[:shop_id])
   @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @shop = @post.shop
  end

  def create
    @shop = Shop.find(params[:shop_id])
    
    @post = Post.new(
      image: post_params[:image],
      title: post_params[:title],
      content: post_params[:content],
      user_id: current_user.id,
      shop_id: params[:shop_id]
      )
      
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to @shop
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @user = @post.user
    @shop = @post.shop
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = '更新されました'
      redirect_to @post
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def destroy
    #binding.pry
    @user = User.find_by(params[:user_id])
    @post.destroy
    flash[:success] = "削除しました"
    redirect_to user_path(@user)
  end
  
  private
    
  def post_params
    params.require(:post).permit(:image, :content, :title, :user_id, :shop_id)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end

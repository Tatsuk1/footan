class PostsController < ApplicationController
  before_action :require_user_logged_in, except:[:index]
  before_action :set_shop, only: [:new, :create]
  before_action :set_post, only: [:show, :edit, :update]
  before_action :correct_user, only: [:destroy]
  
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(20)
  end
  
  def new
    @post = current_user.posts.new
  end

  def show
    @shop = @post.shop
  end

  def create
    @post = current_user.posts.build(
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
    @user = @post.user
    @shop = @post.shop
  end

  def update
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
    @user = @post.user
    @post.destroy
    flash[:success] = "削除しました"
    redirect_to @user
  end
  
  private
  
    def set_shop
      @shop = Shop.find(params[:shop_id])
    end
    
    def set_post
      @post = Post.find(params[:id])
    end
    
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

class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :likes, :like_shops, :random_shops]
  before_action :admin_user, only: [:index, :destroy] 

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.order(id: :desc)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in @user
      flash[:success] = 'ユーザを登録しました'
      redirect_to '/'
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash.now[:danger] = "ユーザー「#{@user.name}を削除しました。」"
    redirect_to users_path
  end

  def likes
    @posts = @user.favo_contents.order(id: :desc)
    counts(@user)
  end
  
  def like_shops
    @shops = @user.favo_shops.order(id: :desc)
    counts(@user)
  end
  
  def random_shops
    @shops = @user.favo_shops.order(id: :desc)
    if @shops.any?
      @shop = @shops.sample(1)
      redirect_to shop_path(@shop)
    else
      flash.now[:danger] = 'お気に入りした店がありません'
      render :like_shops
    end
  end
  
  private
    
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation, :image)
    end
    
    def correct_user
      @user = User.find_by(id: params[:id])
      redirect_to root_url if current_user != @user 
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

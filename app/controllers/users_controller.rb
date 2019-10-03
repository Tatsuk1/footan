class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :likes]
   
  def index
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
  
  def likes
    @posts = @user.favo_contents.order(id: :desc)
    counts(@user)
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
end

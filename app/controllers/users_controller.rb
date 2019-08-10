class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  before_action :correct_user, only: [:edit, :update]
   
  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to '/login'
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @favo_contents = @user.favo_contents.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation, :image)
  end
  
  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url if current_user != @user
  end
end

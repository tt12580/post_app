class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,only: [:edit, :update]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])

  end

  def create
    @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "SUCCESS"
        redirect_to @user
      else
        render 'new'
      end
  end

  def destroy
    @user = User.find(params[:id])
      if @user.destroy
        flash[:success] = "DELETED"
      else
        flash[:danger] = "ERROR"
      end
      redirect_to users_url
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "SUCCESS"
      redirect_to @user
    else
      flash[:danger] = "ERROR"
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

      def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation)
      end

    # 前置过滤器
    # 确保用户已登录
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end

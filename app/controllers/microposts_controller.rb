class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,only: :destroy
    def index
      @microposts = Micropost.all
      if logged_in?
        @micropost = current_user.microposts.build
        @feed_items = current_user.feed.paginate(page: params[:page])
      end
    end

    def show
      @micropost = Micropost.find(params[:user_id])
    end

    def edit
      @micropost = Micropost.find(params[:user_id])
    end

    def new
      @micropost = Micropost.new
    end

    def create
      @micropost = current_user.microposts.build(micropost_params)
      if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_url
      else
        @feed_items = []
        render 'new'
    end
end

    def update
      @micropost = Micropost.find(params[:user_id])
      if @micropost.update_attributes(micropost_params)
        flash[:success] = "SUCCESS"
        redirect_to @micropost
      else
        render 'edit'
    end
  end

    def destroy
      @micropost.destroy
      flash[:success] = "Micropost deleted"
      redirect_to request.referrer || root_url
    end

    private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end

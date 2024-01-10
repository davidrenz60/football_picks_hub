class PoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_pool_creator, only: [:show, :edit, :update, :destroy, :add_user, :remove_user]
  layout :dashboard_layout

  def index
    @pools = current_user.created_pools
  end

  def show
  end

  def new
    @pool = Pool.new
  end

  def edit
  end

  def create
     @pool = Pool.new(pool_params)
     @pool.creator_id = current_user.id
     process_user_emails

    if @pool.save
      redirect_to pools_path
    else
      render 'new'
    end
  end

  def update
    if @pool.update(pool_params)
      redirect_to pool_path(@pool)
    else
      render 'edit'
    end
  end

  def destroy
    @pool.destroy
    redirect_to pools_path
  end

  def add_user
    @user = User.find_by(email: user_pool_params[:user_email])

    if @user && !@pool.users.include?(@user)
      @pool.users << @user
    elsif  @pool.users.include?(@user)
      flash.now[:alert] = "Member already in this pool"
    else
      flash.now[:alert] = "Member not found"
    end
  end

  def remove_user
    @user = User.find(params[:user_id])
    @pool.users.destroy(@user)
  end

  private

  def invite_user
    #will email user to invite to join
  end

  def require_pool_creator
    @pool = Pool.find(params[:id])
    redirect_to root_path, alert: "Not authorized to view that page" if @pool.creator_id != current_user.id
  end

  def process_user_emails
    return if pool_params["users_attributes"].blank?

    pool_params["users_attributes"].values.each do |attr|
      user = User.find_by(email: attr["email"])
      if user
        @pool.users << user
      else
        invite_user
      end
    end
  end

  def pool_params
    params.require(:pool).permit(:name, users_attributes: [:email])
  end

  def user_pool_params
    params.require(:pool).permit(:user_email)
  end
end
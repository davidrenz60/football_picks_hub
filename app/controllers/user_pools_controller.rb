class UserPoolsController < ApplicationController
  before_action :authenticate_user!
  layout :dashboard_layout

  def index
    @user = User.find(params[:id])
    @pools = @user.pools
  end

  def show
    @pool = Pool.find(params[:id])
  end

  private

  def require_user_in_pool

  end
end
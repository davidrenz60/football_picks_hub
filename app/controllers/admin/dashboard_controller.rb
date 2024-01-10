class Admin::DashboardController < ApplicationController
  before_action :require_admin
  layout :dashboard_layout

  def index
  end
end
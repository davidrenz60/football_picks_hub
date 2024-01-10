class Admin::WeeksController < ApplicationController
  layout :dashboard_layout

  def index
    @weeks = Game::WEEKS
  end

  def show
    @week = params[:id]
  end
end
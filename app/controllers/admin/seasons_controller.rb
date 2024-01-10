class Admin::SeasonsController < ApplicationController
  layout :dashboard_layout
  before_action :require_admin

  def index
    @seasons = Game.seasons
  end

  def show
    @season = params[:id]
  end

  def week
    @season = params[:season_id]
    @week = params[:week_id]

    @games = Game.where(season: @season, game_week: "Week #{@week}")
  end

  def update_week
    week = params[:week_id]
    season = params[:season_id]

    service.fetch_weekly_scores(season, week)

    if service.successful?
      redirect_to admin_season_week_path(season, week), notice: "Updated scores for Week #{week}"
    else
      redirect_to admin_season_week_path(season, week), alert: service.error_message
    end
  end

  def create
    season = params["year"]

    if loaded?(season)
      redirect_to admin_seasons_path, alert: "Season already loaded."
      return
    end

    if not_available(season)
      redirect_to admin_seasons_path, alert: "Season not available."
      return
    end

    service.fetch_season(season)

    if service.successful?
      redirect_to admin_seasons_path, notice: "Successfuly fetched season."
    else
      redirect_to admin_seasons_path, alert: service.error_message
    end
  end

  def destroy
    season = params[:id]
    Game.delete_season(season)
    redirect_to admin_seasons_path, notice: "#{season} Season deleted."
  end

  private

  def service
    @service ||= NflService.new
  end

  def loaded?(season)
    Game.seasons.include?(season)
  end

  def not_available(season)
    season.to_i < 2022
  end
end
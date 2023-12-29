class GamesController < ApplicationController
  layout :dashboard_layout

  def index
    conn = Faraday.new(
      url: "https://tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com/getNFLGamesForWeek?week=1&seasonType=reg&season=2023",
      headers: {
        'X-RapidAPI-Key': Rails.application.credentials.X_RapidAPI_Key,
        'X-RapidAPI-Host': 'tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com'
      }
    )
    resp = conn.get
    data = JSON.parse(resp.body)
    game = data["body"][0]

    @game = Game.new(
      game_id: game["gameID"],
      home: game["home"],
      away: game["away"],
      game_week: game["gameWeek"]
      )
  end
end
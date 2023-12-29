class GamesController < ApplicationController
  layout :dashboard_layout

  def index
    conn = Faraday.new(
      url: "https://tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com/getNFLGamesForWeek?week=1&seasonType=reg&season=2023",
      headers: {
        'X-RapidAPI-Key': '9af3a77c52msh0983dc4308a2ab9p1888f5jsn79ffa051e249',
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
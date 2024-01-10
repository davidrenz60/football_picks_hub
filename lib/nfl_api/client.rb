module NflApi
  class RequestFailure < StandardError; end

  class Client
    BASE_URL = "https://tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com"
    HOST_NAME = 'tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com'

    def fetch_season(season)
      connection.get "/getNFLGamesForWeek?week=all&seasonType=reg&season=#{season}"
    end

    def fetch_weekly_scores(season, week)
      connection.get "/getNFLScoresOnly?gameWeek=#{week}&season=#{season}"
    end

    def fetch_weekly_scores_for_season(season, seasonLength)
      data = []
      (1..seasonLength).each do |week|
        data << fetch_weekly_scores(season, week.to_s)
      end

      data
    end

     private

    def connection
      options = {
        url: BASE_URL,
        headers: {
        'X-RapidAPI-Key': Rails.application.credentials.X_RapidAPI_Key,
        'X-RapidAPI-Host': HOST_NAME
        }
      }

      @connection ||= Faraday.new(options) do |conn|
        conn.use Middleware::StatusCheck
        conn.use Middleware::JsonParsing
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
class NflService
  attr_reader :error_message

  def fetch_season(season)
    begin
      seasonData = client.fetch_season(season)
      seasonScoresData = client.fetch_weekly_scores_for_season(season, Game::WEEKS)
      create_season(seasonData, seasonScoresData)
      @status = :success

    rescue NflApi::RequestFailure => e
      handle_error(e)
    rescue ActiveRecord::RecordInvalid => e
      handle_error(e)
    end
  end

  def fetch_weekly_scores(season, week)
    begin
      data = client.fetch_weekly_scores(season, week)
      update_weekly_scores(data)
      @status = :success
    rescue NflApi::RequestFailure => e
      handle_error(e)
    rescue ActiveRecord::RecordInvalid => e
      handle_error(e)
    end
  end

  def successful?
    @status == :success
  end

  def error?
    @status == :error
  end

  private

  def handle_error(e)
    @status = :error
    @error_message = e.message
  end

  def client
    @client ||= NflApi::Client.new
  end

  def update_weekly_scores(data)
    data.body["body"].each do |scoreData|
      game_id = scoreData[0]
      data = scoreData[1]
      game = Game.find_by(game_id: game_id)

      if game
        game.update!(
          away_pts: data["awayPts"],
          home_pts: data["homePts"],
          game_status: data["gameStatus"],
          game_clock: data["gameClock"]
          )
      else
        raise ActiveRecord::RecordInvalid.new, "Could not find game to update. game_id: #{game_id}, data: #{data}"
      end
    end
  end

  def create_season(seasonData, seasonScoresData)
    gamesData = seasonData.body["body"]

    Game.transaction do
      gamesData.each do |gameData|
        newGame = Game.create!(
          game_id: gameData["gameID"],
          season_type: gameData["seasonType"],
          away: gameData["away"],
          game_date: gameData["gameDate"],
          espn_id: gameData["espnID"],
          team_id_home: gameData["teamIDHome"],
          game_status: gameData["gameStatus"],
          game_week: gameData["gameWeek"],
          team_id_away: gameData["teamIDAway"],
          home: gameData["home"],
          game_time: gameData["gameTime"],
          season: gameData["season"]
          )
      end

      seasonScoresData.each do |weeklyScoreData|
        weeklyScoreData.body["body"].each do |scoreData|
          game_id = scoreData[0]
          data = scoreData[1]
          game = Game.find_by(game_id: game_id)

          if game
            game.update!(
              away_pts: data["awayPts"],
              home_pts: data["homePts"],
              game_status: data["gameStatus"],
              game_clock: data["gameClock"]
              )
          else
            raise ActiveRecord::RecordInvalid.new, "Could not find game to update. game_id: #{game_id}, data: #{data}"
          end
        end
      end
    end
  end
end
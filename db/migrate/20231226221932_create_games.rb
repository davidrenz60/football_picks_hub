class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :away
      t.string :home
      t.string :team_id_away
      t.string :team_id_home
      t.time :game_time
      t.string :game_id
      t.integer :away_pts
      t.integer :home_pts
      t.string :game_clock
      t.string :game_status
      t.string :season_type
      t.string :game_date
      t.string :espn_id
      t.string :game_week
      t.string :season

      t.timestamps
    end
  end
end

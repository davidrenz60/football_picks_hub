class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :game_id
      t.string :season_type
      t.string :away
      t.date :game_date
      t.string :espn_id
      t.string :team_id_home
      t.string :game_status
      t.string :game_week
      t.string :team_id_away
      t.string :home
      t.time :game_time
      t.string :season
      t.boolean :neutral_site

      t.timestamps
    end
  end
end

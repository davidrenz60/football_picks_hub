class ChangeGameDateTypeInGames < ActiveRecord::Migration[7.1]
  def up
    change_column :games, :game_date, 'date USING CAST(game_date AS date)'
  end

  def down
    change_column :games, :game_date, :string
  end
end

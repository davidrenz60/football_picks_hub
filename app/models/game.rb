class Game < ApplicationRecord
  validates :game_id, uniqueness: true, presence: true

  WEEKS = 18

  def self.seasons
    self.distinct.pluck(:season)
  end

  def self.delete_season(season)
    Game.where(season: season).destroy_all
  end
end
# frozen_string_literal: true

class AddSeasonDatesToLeagues < ActiveRecord::Migration[7.1]

  SEASON_START_COMMENT = 'Date the upcoming or last season starts for a league'
  SEASON_END_COMMENT = 'Date the upcoming or last season ends for a league'

  def change
    change_table :leagues, bulk: true do |t|
      t.date :season_start, comment: SEASON_START_COMMENT
      t.date :season_end, comment: SEASON_END_COMMENT
    end
  end

end

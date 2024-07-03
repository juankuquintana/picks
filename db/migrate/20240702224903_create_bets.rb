# frozen_string_literal: true

class CreateBets < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores the bets or prediction information'

  def change
    create_table :bets, comment: TABLE_COMMENT do |t|
      t.integer :home_team_score, null: false, comment: 'Score for the home team'
      t.integer :away_team_score, null: false, comment: 'Score for the away team'
      t.integer :points, comment: 'Points obtained for the bet'
      t.references :fixture, foreign_key: true, null: false, comment: 'Fixture associated to this bet'
      t.references :pool, foreign_key: true, null: false, comment: 'Pool associated to this bet'
      t.references :user, foreign_key: true, null: false, comment: 'User that placed the bet'

      t.timestamps
    end

    add_index :bets, %i[fixture_id pool_id user_id], unique: true
  end

end

# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores teams related information'

  def change
    create_table :teams, comment: TABLE_COMMENT do |t|
      t.string :name, limit: 255, null: false, comment: 'The team name'
      t.text :logo, null: false, comment: 'URL of the team logo image'
      t.jsonb :adapters, null: false, comment: 'Stores the reference IDs of the team from our different providers'

      t.timestamps
    end
  end

end

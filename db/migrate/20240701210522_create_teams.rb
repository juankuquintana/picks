class CreateTeams < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores a team information'

  def change
    create_table :teams, comment: TABLE_COMMENT do |t|
      t.string :name, limit: 255, null: false, comment: 'The team name'
      t.string :code, comment: 'The 3 letter code for a team'
      t.text :logo, comment: 'The logo or flag of a team'
      t.jsonb :adapters, null: false, comment: 'Stores the reference IDs of the team from our different providers'

      t.timestamps
    end
  end
end

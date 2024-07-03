# frozen_string_literal: true

class CreatePools < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores a pool information'

  def change
    create_table :pools, comment: TABLE_COMMENT do |t|
      t.string :name, limit: 255, null: false, comment: 'Name of the pool'
      t.string :code, limit: 20, null: false, index: { unique: true }, comment: 'Unique code of the pool for invitations'
      t.references :league, foreign_key: true, null: false, comment: 'References the league associated to this pool'
      t.references :round, foreign_key: true, null: false, comment: 'Initial round of the league associated to this pool'

      t.timestamps
    end
  end

end

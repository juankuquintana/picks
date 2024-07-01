# frozen_string_literal: true

class CreateLeagues < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores leagues related information'

  def change
    create_table :leagues, comment: TABLE_COMMENT do |t|
      t.string :name, limit: 255, null: false, comment: 'The league name'
      t.text :logo, null: false, comment: 'URL of the league logo image'
      t.jsonb :adapters, null: false, comment: 'Stores the reference IDs of the league from our different providers'
      t.references :country, foreign_key: true, null: false, comment: 'References the country associated to this league'

      t.timestamps
    end
  end

end

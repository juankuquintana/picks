# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores countries related information'

  def change
    create_table :countries, comment: TABLE_COMMENT do |t|
      t.string :name, limit: 255, null: false, comment: 'The country name'
      t.string :code, limit: 2, comment: 'The country ISO 3166-1 alpha-2'
      t.text :flag, comment: 'URL of the country flag image'

      t.timestamps
    end
  end

end

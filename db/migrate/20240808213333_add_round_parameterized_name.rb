# frozen_string_literal: true

class AddRoundParameterizedName < ActiveRecord::Migration[7.1]

  COMMENT = 'The parameterized name of a round'

  def change
    add_column :rounds, :parameterized_name, :string, null: false, comment: COMMENT
    add_index :rounds, %i[parameterized_name season league_id], unique: true
  end

end

# frozen_string_literal: true

class AddTeamParameterizedName < ActiveRecord::Migration[7.1]

  COMMENT = 'The parameterized name of a team'

  def change
    add_column :teams, :parameterized_name, :string, null: false, comment: COMMENT
    add_index :teams, %i[parameterized_name], unique: true
  end

end

class AddLeagueParameterizedName < ActiveRecord::Migration[7.1]

  COMMENT = 'The parameterized name of a league'

  def change
    add_column :leagues, :parameterized_name, :string, null: false, comment: COMMENT
    add_index :leagues, %i[parameterized_name], unique: true
  end

end

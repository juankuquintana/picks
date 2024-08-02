# frozen_string_literal: true

class AddStateToFixtures < ActiveRecord::Migration[7.1]

  COMMENT = 'State (status) of a fixture'

  def change
    add_column :fixtures, :state, :string, null: false, comment: COMMENT
  end

end

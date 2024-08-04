# frozen_string_literal: true

class AddStateToLeagues < ActiveRecord::Migration[7.1]

  COMMENT = 'State (status) of a league'

  def change
    add_column :leagues, :state, :string, null: false, comment: COMMENT, default: League::STATE_ACTIVE
  end

end

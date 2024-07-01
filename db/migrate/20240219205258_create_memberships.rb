# frozen_string_literal: true

class CreateMemberships < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores memberships which associates users and accounts'

  def change
    create_table :memberships, comment: TABLE_COMMENT do |t|
      t.references :user, foreign_key: true, null: false, comment: 'Reference to the user associated with this membership'
      t.references :account, foreign_key: true, null: false, comment: 'Reference to the account associated with this membership'
      t.boolean :primary, default: false, null: false, comment: 'Identifies the primary account of a user'

      t.timestamps
    end

    add_index :memberships, %i[user_id account_id], unique: true
  end

end

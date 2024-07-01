# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores account information associated with users'

  def change
    create_table :accounts, comment: TABLE_COMMENT do |t|
      t.string :email, limit: 255, null: false, index: { unique: true },
                       comment: 'Email address associated with the user'
      t.string :name, limit: 255, comment: 'Name associated with the account'

      t.timestamps
    end
  end

end

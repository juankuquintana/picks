# frozen_string_literal: true

class CreateUserIdentities < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores the user identity providers associated to a user for authentication'

  def change
    create_table :user_identities, comment: TABLE_COMMENT do |t|
      t.references :user, foreign_key: true, null: false, comment: 'Reference to the user associated with this identity'
      t.string :email, limit: 255, null: false, comment: 'Email address associated with this identity'
      t.string :name, limit: 255, null: false, comment: 'Name associated with this identity'

      t.timestamps
    end
  end

end

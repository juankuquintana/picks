# frozen_string_literal: true

class CreatePoolUsers < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores the relation between pool and users'

  def change
    create_table :pool_users, comment: TABLE_COMMENT do |t|
      t.string :role, limit: 255, null: false, comment: 'Role of the user and the pool'
      t.references :pool, foreign_key: true, null: false, comment: 'Pool associated to a user'
      t.references :user, foreign_key: true, null: false, comment: 'User associated to a pool'

      t.timestamps
    end
  end

end

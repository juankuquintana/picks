# frozen_string_literal: true

class CreateOrder < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores orders related information'

  def change
    create_table :orders, comment: TABLE_COMMENT do |t|
      t.references :user, foreign_key: true, null: false, comment: 'Reference to the user associated with this order'
      t.references :account, foreign_key: true, null: false, comment: 'Reference to the account associated with this order'
      t.string :state, limit: 255, null: false, comment: 'Holds the state of the order'
      t.datetime :last_processed_at, comment: 'Holds the time the order was last processed'
      t.integer :runs, null: false, comment: 'Holds the amount of times the order has been ran'

      t.timestamps
    end
  end

end

# frozen_string_literal: true

class CreateActivityLogs < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores a log of relevant activities performed to/by our users, on their accounts and models'

  def change
    create_table :activity_logs, comment: TABLE_COMMENT do |t|
      t.references :user, foreign_key: true, null: true, comment: 'Reference to the user associated with this activity log'
      t.references :account, foreign_key: true, null: true, comment: 'Reference to the account associated with this activity log'
      t.string :name, limit: 255, null: false, comment: 'Name used to identify the type of activity log'
      t.string :actor, limit: 255, null: false, comment: 'Actor that caused the activity log'
      t.jsonb :identifiers, comment: 'Associated models relevant to the activity log'
      t.jsonb :data, comment: 'Associated data relevant to the activity log'

      t.timestamps
    end
  end

end

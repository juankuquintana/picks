# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores user authentication-related data'

  def change
    create_table :users, comment: TABLE_COMMENT do |t|
      t.string :email, limit: 255, null: false, index: { unique: true },
                       comment: 'Email address associated with the user'
      t.string :session_token, limit: 255, null: false, index: { unique: true },
                               comment: 'Unique session token used for authentication'
      t.boolean :passwordless, default: false, null: false,
                               comment: 'Indicates if the user has enabled passwordless authentication'
      t.datetime :admin_at, comment: 'Indicates when the user was granted admin privileges'
      t.datetime :last_login_at, comment: 'Indicates the time when the user last logged in'

      t.timestamps
    end
  end

end

# frozen_string_literal: true

class CreateItemEvent < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores item events related information'

  def change
    create_table :item_events, comment: TABLE_COMMENT do |t|
      t.references :item, polymorphic: true, null: false, comment: 'References the model associated to this record'
      t.string :actor, limit: 255, null: false, comment: 'Holds the actor of the event'
      t.string :event_type, limit: 255, null: false, comment: 'Holds the type of the event'
      t.jsonb :data, comment: 'Holds any additional data of the event'

      t.timestamps
    end
  end

end

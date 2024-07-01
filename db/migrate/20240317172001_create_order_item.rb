# frozen_string_literal: true

class CreateOrderItem < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores order items related information'

  def change
    create_table :order_items, comment: TABLE_COMMENT do |t|
      t.references :order, foreign_key: true, null: false, comment: 'Reference to the parent order associated with this order item'
      t.references :order_item, polymorphic: true, null: false, comment: 'References the model associated to this order item'
      t.string :state, limit: 255, null: false, comment: 'Holds the state of the order item'
      t.text :failure_description, comment: 'Holds the description of the order item error'

      t.timestamps
    end
  end

end

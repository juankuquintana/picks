# frozen_string_literal: true

class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :order_item, polymorphic: true

  STATE_NEW        = :new
  STATE_PROCESSING = :processing
  STATE_PROCESSED  = :processed
  STATE_FAILED     = :failed
  STATE_CANCELLED  = :cancelled

end

# frozen_string_literal: true

class Order < ApplicationRecord

  belongs_to :account
  belongs_to :user
  has_many :order_items, dependent: :destroy

  STATE_NEW        = :new
  STATE_PROCESSING = :processing
  STATE_PROCESSED  = :processed
  STATE_FAILED     = :failed
  STATE_CANCELLED  = :cancelled

  def sync_state
    update!(state: projected_state)
  end

  private

  def projected_state
    states = order_items.pluck(:state).uniq

    infer_state_from_states(states)
  end

  def infer_state_from_states(states)
    return STATE_FAILED if states.include?(OrderItem::STATE_FAILED.to_s)
    return STATE_NEW if states.empty? || states.include?(OrderItem::STATE_NEW.to_s)
    return STATE_CANCELLED if states == [OrderItem::STATE_CANCELLED.to_s]
    return STATE_PROCESSED if states == [OrderItem::STATE_PROCESSED.to_s]

    STATE_PROCESSING
  end

end

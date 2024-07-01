# frozen_string_literal: true

class OrderQuery

  include Picks::Query

  # Selects a list of orders that need processing.
  #
  # @return [ActiveRecord::Relation]
  def self.needs_processing
    scope.where(state: [Order::STATE_NEW, Order::STATE_PROCESSING])
  end

end

# frozen_string_literal: true

module Picks
  module Query

    PATTERN_ID = /\A\d+\z/
    LEADING_ID = /\A\d+-/

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      # Returns the scope class for this query.
      #
      # @return [Class] the scope class
      def scope
        infer_model_class
      end

      # Infers the model class from the query class name.
      #
      # @return [Class] the inferred model class
      def infer_model_class
        class_name = name.chomp('Query')
        class_name.constantize
      end

    end

  end
end

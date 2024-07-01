module ERBLint
  module Linters
    class QuotesInHtmlAttributes < Linter
      include LinterRegistry

      class ConfigSchema < LinterConfig
        property :enforced_quote_style, converts: :to_sym, accepts: [:single, :double], default: :double
      end
      self.config_schema = ConfigSchema


      def run(processed_source)
        parser = processed_source.parser
        parser.nodes_with_type(:tag).each do |tag_node|
          tag = BetterHtml::Tree::Tag.from_node(tag_node)
          next if tag.closing?

          tag.attributes.each do |attribute|
            quote = attribute.value_node&.children&.first
            next unless quote&.type == :quote

            # Quote is a BetterHtml::AST::Node at this point = s(:quote, "'")
            quote = quote.children.first

            # Quote is now either ' || "
            quote_style = quote == "'" ? :single : :double
            next if quote_style == @config.enforced_quote_style

            add_offense(
              attribute.value_node.loc,
              "Use #{@config.enforced_quote_style} quotes for HTML attributes",
              nil,
              :convention
            )
          end
        end
      end

      def autocorrect(_processed_source, offense)
        lambda do |corrector|
          new_quote = @config.enforced_quote_style == :single ? "'" : '"'
          new_source = offense.source_range.source.gsub(/^\s*['"]/, new_quote).gsub(/['"]\s*$/, new_quote)
          corrector.replace(offense.source_range, new_source)
        end
      end
    end
  end
end

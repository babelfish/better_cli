module BetterCli
  class Option
    module Mixin
      def option(name, &block)
        opt = Option.new(name).instance_exec(&block)

        [name.to_sym].concat(opt.aliases).each do |symbol|
          options[symbol] = opt
        end
      end

      def options
        @options ||= {}
      end

      def collect_options
        parent_options.merge(options)
      end

      def parent_options
        respond_to?(:parent) ? parent.collect_options : {}
      end
    end

    OPTION_TYPES = %i[boolean magnitude integer float string array hash].freeze

    include Mixin

    def aliases(*aliases)
      @aliases ||= aliases.map(&:to_sym)
    end

    def default(default = nil)
      @default ||= default
    end

    def type(type = nil)
      return @type if type.nil?

      raise ArgumentError, "BetterCli::Option#type can only accept the following symbols: #{OPTION_TYPES.join(', ')}" unless OPTION_TYPES.include?(type)

      @type = type
    end

    def validator(&block)
      @validator ||= block
    end

    def wrapper(&block)
      @wrapper ||= block
    end

    def takes_argument?
      (OPTION_TYPES - %i[boolean magnitude]).include?(type)
    end
  end
end

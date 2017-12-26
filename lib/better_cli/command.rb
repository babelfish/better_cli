require 'better_cli/option'

module BetterCli
  class Command
    module Mixin
      def command(name_or_command, &block)
        case name_or_command
        when Command
          command = name_or_command
          name    = command.name
        when String, Symbol
          name    = name_or_command.to_sym
          command = Command.new(name)
        else
          raise ArgumentError, 'Invalid value given to BetterCli::Cli#command, expected String, Symbol or BetterCli::Command.'
        end

        command.parent = self

        command.instance_exec(&block) if block

        commands[name] = command
      end

      def commands
        @commands ||= {}
      end
    end

    include Mixin
    include Option::Mixin

    attr_accessor :parent
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def exec(&block)
      @exec = block
    end
  end
end

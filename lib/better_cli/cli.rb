require 'better_cli/command'
require 'better_cli/default_logger'
require 'better_cli/option'
require 'better_cli/parser'

module BetterCli
  class Cli
    include Command::Mixin
    include Option::Mixin

    attr_accessor :version

    def initialize
      @logger = DefaultLogger.new(STDOUT)

      yield_self if block_given?
    end

    def logger(logger)
      @logger = logger
    end

    def run!(argv = ARGV)
      command, options = Parser.new(self, argv).parse
    end
  end
end

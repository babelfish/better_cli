require 'logger'

module BetterCli
  class DefaultLogger < Logger
    def initialize(*)
      super

      self.formatter = ->(_, _, _, message) { message }
    end
  end
end

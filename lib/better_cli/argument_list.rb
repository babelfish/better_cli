module BetterCli
  class ArgumentList
    attr_reader :cli

    def initialize(cli, argv)
      @cli   = cli
      @flags = extract_flags!(argv)
    end

    private

    def extract_flags!(argv)
      argv
        .map { |arg| /^(?:-([a-zA-Z0-9]+))/.match(arg) }
        .flat_map(&:separate_flags)
    end
  end
end

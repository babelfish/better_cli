require 'better_cli/command'

module BetterCli
  class Parser
    SHORT_OPTION_FILTER = ->(arg) { arg =~ /^-[^-]/ }
    LONG_OPTION_FILTER  = ->(arg) { arg =~ /^--/ }

    def initialize(cli, arguments)
      @cli       = cli
      @arguments = arguments
    end

    def parse
      extract_raw_argument!
      extract_command!
      extract_options!

      [command, materialized_options]
    end

    private

    attr_reader :cli, :arguments, :command, :options

    def extract_raw_argument!
      return unless separator_index = arguments.index('--')

      @raw_argument = arguments.drop(separator_index + 1).join(' ')
    end

    def extract_command!(source: cli, input: arguments)
      return @command = cli.commands[:help] if input.empty? && source == cli
      return @command = attempt_to_infer_command_from_option if next_arg_is_option? && source == cli
      return @command = extract_command!(source: command, input: arguments.drop(1)) if source.commands[next_arg.to_sym]

      if source.is_a?(Command)
        @command   = source
        @arguments = input

        return
      end

      cli.warn("#{next_arg} is not a valid command.")

      @command = cli.commands[:help]
    end

    def extract_options!
      extract_short_options!
      extract_long_options!
    end

    def extract_short_options!
      short_options = arguments.select(&SHORT_OPTION_FILTER)
      @arguments    = arguments.reject!(&SHORT_OPTION_FILTER)
    end

    def extract_long_options!
      long_options = arguments.select(&LONG_OPTION_FILTER)
      @arguments   = arguments.reject!(&LONG_OPTION_FILTER)
    end

    def next_arg
      input.first
    end

    def next_arg_is_option?
      next_arg.start_with?('-')
    end

    def attempt_to_infer_command_from_option
      return cli.commands[:version] if ['-v', '--version'].include?(next_arg)

      return cli.commands[:help]
    end
  end
end

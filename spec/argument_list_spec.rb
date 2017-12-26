module BetterCli
  RSpec.describe ArgumentList do
    let(:cli) { instance_double(Cli) }

    subject { described_class.new(cli, argv) }

    describe 'flag extraction' do
    end
  end
end

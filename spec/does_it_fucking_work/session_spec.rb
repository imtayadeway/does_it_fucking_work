require "spec_helper"

RSpec.describe DoesItFuckingWork::Session do
  it "executes the strategy" do
    strategy = spy("strategy")
    session = described_class.new(strategy: strategy)

    Thread.new do
      session.go
    end
    sleep(0.01)
    session.stop

    expect(strategy).to have_received(:setup)
    expect(strategy).to have_received(:tick).at_least(:once)
  end
end

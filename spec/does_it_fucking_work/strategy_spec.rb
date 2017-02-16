require "spec_helper"

RSpec.describe DoesItFuckingWork::Strategy do
  describe "#setup" do
    it "gets setup" do
      client = spy("client")
      strategy = build_strategy(client: client) do |setup|
        setup.visit "http://example.com"
      end

      strategy.setup

      expect(client).to have_received(:visit).with("http://example.com")
    end
  end

  describe "#tick" do
    it "clicks through links" do
      link = spy("link")
      client = stub_client_with_page(links: [link])
      strategy = build_strategy(client: client)

      strategy.tick

      expect(link).to have_received(:click)
    end

    it "clicks through buttons" do
      button = spy("button")
      client = stub_client_with_page(buttons: [button])
      strategy = build_strategy(client: client)

      strategy.tick

      expect(button).to have_received(:click)
    end

    it "raises on a server error" do
      client = double("client", status_code: 500)
      strategy = build_strategy(client: client)

      expect do
        strategy.tick
      end.to raise_error(described_class::ItDoesntFuckingWorkError)
    end

    it "recovers from capybara errors" do
      link = double("link")
      allow(link).to receive(:click).and_raise
      client = stub_client_with_page(links: [link])

      expect { build_strategy(client: client).tick }.not_to raise_error
    end
  end

  def build_strategy(client:, &block)
    described_class.new(client: client, &block).tap do |strategy|
      allow(strategy).to receive(:sleep)
    end
  end

  def stub_client_with_page(links: [], buttons: [])
    double("client", status_code: 200).tap do |client|
      allow(client).to receive(:all).with(:link).and_return(links)
      allow(client).to receive(:all).with(:button).and_return(buttons)
    end
  end
end

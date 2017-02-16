module DoesItFuckingWork
  class Strategy
    ItDoesntFuckingWorkError = Class.new(StandardError)

    attr_reader :client

    def initialize(client: Capybara::Session.new(:poltergeist), &block)
      @client = client
      @setup = block
    end

    def setup
      @setup.call(client) if @setup
    end

    def tick
      client.status_code >= 500 and raise ItDoesntFuckingWorkError
      sleep(rand(999) / 500.0)
      *clickables = *client.all(:link), *client.all(:button)
      begin
        clickables.sample.click
      rescue
      end
    end
  end
end

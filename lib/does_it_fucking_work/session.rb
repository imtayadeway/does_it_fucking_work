module DoesItFuckingWork
  class Session
    attr_reader :timeout, :strategy

    def initialize(timeout:, strategy:)
      @timeout = timeout
      @strategy = strategy
      @done = false
    end

    def go
      set_timeout
      strategy.setup

      loop do
        break if @done
        strategy.tick
      end
    end

    def stop
      @done = true
    end

    private

    def set_timeout
      Thread.new do
        sleep(timeout)
        stop
      end
    end
  end
end

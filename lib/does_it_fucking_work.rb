require "does_it_fucking_work/version"
require "does_it_fucking_work/session"
require "does_it_fucking_work/strategy"
require "capybara"
require "capybara/poltergeist"

module DoesItFuckingWork
  def self.go(page)
    strategy = Strategy.new { |setup| setup.visit page }
    Session.new(strategy: strategy, timeout: 15).go
    puts "It fucking works!"
  rescue
    puts "It doesn't fucking work!"
  end
end

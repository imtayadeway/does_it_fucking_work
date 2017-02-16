# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'does_it_fucking_work/version'

Gem::Specification.new do |spec|
  spec.name          = "does_it_fucking_work"
  spec.version       = DoesItFuckingWork::VERSION
  spec.authors       = ["Tim Wade"]
  spec.email         = ["hello@timjwade.com"]

  spec.summary       = "does_it_fucking_work-#{spec.version}"
  spec.description   = %q{An acceptance test framework}
  spec.homepage      = "https://github.com/imtayadeway/does_it_fucking_work"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara", "~> 2.0"
  spec.add_dependency "poltergeist", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

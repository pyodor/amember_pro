# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amember_pro/version'

Gem::Specification.new do |spec|
  spec.name          = "amember_pro"
  spec.version       = AmemberPro::VERSION
  spec.authors       = ["Diosdado Campo"]
  spec.email         = ["csicebu@gmail.com"]
  spec.summary       = %q{aMember Pro Web API REST client}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "webmock"
  spec.add_dependency "faraday"
  spec.add_dependency "dish"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blinkman/version'

Gem::Specification.new do |spec|
  spec.name          = "blinkman"
  spec.version       = Blinkman::VERSION
  spec.authors       = ["Kinoshita.Yasuhiro"]
  spec.email         = ["WhoIsDissolvedGirl+github@gmail.com"]

  spec.summary       = %q{Blinkman is the DSL for blink(1)}
  spec.description   = %q{Blinkman is the DSL for blink(1)}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rb-blink1", "~> 0.0.7"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end

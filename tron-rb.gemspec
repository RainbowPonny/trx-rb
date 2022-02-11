# frozen_string_literal: true

require_relative "lib/tron/rb/version"

Gem::Specification.new do |spec|
  spec.name          = "tron-rb"
  spec.version       = Tron::Rb::VERSION
  spec.authors       = ["Anton Kostyuk"]
  spec.email         = ["anton.kostuk.2012@gmail.com"]

  spec.summary       = "TRON HTTP API client"
  spec.description   = ""
  spec.homepage      = "https://github.com/RainbowPonny/tron-rb"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = true

  spec.files = Dir["lib/**/*"]

  spec.add_development_dependency "rspec", "~> 3.2"

  spec.add_dependency "faraday", "~> 1.7.1"
end

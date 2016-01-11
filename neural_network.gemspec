# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'neural_network/version'

Gem::Specification.new do |spec|
  spec.name          = "neural_network"
  spec.version       = NeuralNetwork::VERSION
  spec.authors       = ["Karmen Blake"]
  spec.email         = ["dudeblake@gmail.com"]

  spec.summary       = %q{Neural Network}
  spec.description   = %q{Neural Network}
  spec.homepage      = "https://github.com/kblake/neural-network"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end

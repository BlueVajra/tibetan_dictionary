# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wylie/version'

Gem::Specification.new do |spec|
  spec.name          = "wylie"
  spec.version       = Wylie::VERSION
  spec.authors       = ["BlueVajra"]
  spec.email         = ["cory.leistikow@gmail.com"]
  spec.summary       = "Converts EWTS into Tibetan Unicode Characters"
  spec.description   = "See above"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

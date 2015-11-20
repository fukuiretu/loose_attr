# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'loose_attr/version'

Gem::Specification.new do |spec|
  spec.name          = "loose_attr"
  spec.version       = LooseAttr::VERSION
  spec.authors       = ["fukuiretu"]
  spec.email         = ["fukuiretu@gmail.com"]

  spec.summary       = %q{loose attr}
  spec.description   = %q{loose_attr}
  spec.homepage      = "https://github.com/fukuiretu/loose_attr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3", "~> 1.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"

  spec.add_dependency "activerecord", ["> 3.0", "< 5.0"]
  spec.add_dependency "hashie"
  spec.add_dependency "wannabe_bool"
end

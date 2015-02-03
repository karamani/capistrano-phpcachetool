# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/phpcachetool/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-phpcachetool"
  spec.version       = Capistrano::Phpcachetool::VERSION
  spec.authors       = ["Yuri Karamani"]
  spec.email         = ["y.karamani@gmail.com"]
  spec.summary       = %q{Capistrano 3 plugin for work with php cache.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end

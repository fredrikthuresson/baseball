# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'baseball/version'

Gem::Specification.new do |gem|
  gem.name          = "baseball"
  gem.version       = Baseball::VERSION
  gem.authors       = ["Fredrik Thuresson"]
  gem.email         = ["fredrik.thuresson@gmail.com"]
  gem.description   = %q{Builds consolidate information from baseball statistics}
  gem.summary       = %q{Builds consolidate information from baseball statistics}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end

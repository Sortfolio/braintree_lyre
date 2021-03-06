# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'braintree_lyre/version'

Gem::Specification.new do |gem|
  gem.name          = "braintree_lyre"
  gem.version       = BraintreeLyre::VERSION
  gem.authors       = ["Eric Marthinsen"]
  gem.email         = ["emarthinsen@agilecommerce.com"]
  gem.description   = %q{A Lyre for Braintree's payment gateway}
  gem.summary       = %q{A Lyre for Braintree's payment gateway}
  gem.homepage      = "https://github.com/Sortfolio/braintree_lyre"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'lyre'
  gem.add_dependency 'braintree'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'debugger'
end
